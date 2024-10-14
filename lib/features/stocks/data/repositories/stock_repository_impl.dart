import 'package:collection/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:exinity_app/const/constants.dart';
import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/network/network_info.dart';
import 'package:exinity_app/core/services/websocket/web_socket_service.dart';
import 'package:exinity_app/features/stocks/data/datasources/stock_api_remote_data_source.dart';
import 'package:exinity_app/features/stocks/data/datasources/stock_websocket_remote_data_sourc.dart';
import 'package:exinity_app/features/stocks/data/datasources/symbols_remote_data_source.dart';
import 'package:exinity_app/features/stocks/data/datasources/watchlist_local_data_source.dart';
import 'package:exinity_app/features/stocks/data/models/stock_api_model.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';

class StockRepositoryImpl extends StockRepository {
  final StockApiRemoteDataSource stockApiRemoteDataSource;
  final SymbolsRemoteDataSource symbolsRemoteDataSource;
  final StockWebsocketRemoteDataSource stockWebsocketRemoteDataSource;
  final NetworkInfo networkInfo;
  final WebSocketService webSocketService;
  final WatchlistLocalDataSource watchListLocalDataSource;

  StockRepositoryImpl(
      {required this.stockApiRemoteDataSource,
      required this.symbolsRemoteDataSource,
      required this.stockWebsocketRemoteDataSource,
      required this.networkInfo,
      required this.webSocketService,
      required this.watchListLocalDataSource});

  List<SymbolEntity> allSymbols = [];
  List<StockEntity> cachedStocks = [];
  List<String> watchlistSymbols = [];

  @override
  Future<Either<Failure, List<SymbolEntity>>> getAllSymbols() async {
    if (await networkInfo.isConnected) {
      final response = await symbolsRemoteDataSource.getAllSymbols();
      return response.fold((failure) => Left(failure), (symbols) {
        if (symbols.isEmpty) {
          return const Left(EmptyDataFailure(message: "No data found"));
        }
        allSymbols = symbols;
        List<String> watchlist =
            watchListLocalDataSource.getWatchlist().getOrElse(() => []);

        if (watchlist.isNotEmpty) {
          for (String symbol in watchlist) {
            allSymbols
                .firstWhereOrNull((element) => element.symbol == symbol)
                ?.isWatchlisted = true;
          }
        }

        return Right(allSymbols);
      });
    } else {
      return const Left(OfflineFailure());
    }
  }

  @override
  Either<Failure, List<String>> getWatchlist() {
    try {
      return watchListLocalDataSource.getWatchlist();
    } catch (e) {
      return Left(LogicFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> addToWatchlist(String symbol) {
    try {
      final symbolEntity =
          allSymbols.firstWhereOrNull((element) => element.symbol == symbol);
      if (symbolEntity == null) {
        return Left(SymbolNotFound(symbol: symbol));
      } else {
        return watchListLocalDataSource.addToWatchlist(symbol);
      }
    } catch (e) {
      return Left(LogicFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> removeFromWatchlist(String symbol) {
    try {
      allSymbols
          .firstWhereOrNull((element) => element.symbol == symbol)
          ?.isWatchlisted = false;
      return watchListLocalDataSource.removeFromWatchlist(symbol);
    } catch (e) {
      return Left(LogicFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StockApiModel>> getStockInfo(String symbol) async {
    if (await networkInfo.isConnected) {
      final response = await stockApiRemoteDataSource.getStockInfo(symbol);
      return response.fold((failure) => Left(failure),
          (StockApiModel stockInfo) {
        return Right(stockInfo);
      });
    } else {
      return const Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<StockEntity>>> getSelectedStocksData(
      StockType stockType) async {
    if (await networkInfo.isConnected) {
      List<String> selectedSymbols = [];
      if (stockType == StockType.popular) {
        selectedSymbols = Constants.popularStocks;
      } else if (stockType == StockType.watchList) {
        selectedSymbols =
            watchListLocalDataSource.getWatchlist().getOrElse(() => []);
      }

      if (allSymbols.isNotEmpty || selectedSymbols.isNotEmpty) {
        final futures = selectedSymbols.map((symbol) async {
          StockEntity? stockEntity =
              cachedStocks.firstWhereOrNull((stock) => stock.symbol == symbol);
          if (stockEntity != null) {
            return Right(stockEntity);
          } else {
            final response =
                await stockApiRemoteDataSource.getStockInfo(symbol);
            return response.fold((failure) => Left(failure), (stockInfo) {
              final symbolEntity = allSymbols
                  .firstWhereOrNull((element) => element.symbol == symbol);
              if (symbolEntity == null) {
                return Left(SymbolNotFound(symbol: symbol));
              }
              StockEntity stock = StockEntity(
                  symbol: symbol,
                  symbolEntity: symbolEntity,
                  changePercentage: stockInfo.percentage,
                  currentPrice: stockInfo.currentPrice,
                  lastClosePrice: stockInfo.lastClosePrice);
              cachedStocks.add(stock);
              webSocketService.subscribeToSymbol(symbol);
              return Right(stock);
            });
          }
        }).toList();

        final results = await Future.wait(futures);

        final selectedStocksData = results
            .whereType<Right>()
            .map((r) => r.value as StockEntity)
            .toList();

        if (selectedStocksData.isEmpty) {
          return const Left(EmptyDataFailure());
        } else {
          return Right(selectedStocksData);
        }
      } else {
        return const Left(EmptyDataFailure());
      }
    } else {
      return const Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<StockEntity>>> updateSelectedStocksPrice(
      {required dynamic dataReceived,
      required List<StockEntity> stocksList}) async {
    if (await networkInfo.isConnected) {
      var response =
          stockWebsocketRemoteDataSource.getPriceUpdate(dataReceived);
      return response.fold((failure) => Left(failure), (stockWebsocketModel) {
        StockEntity? stockEntity = cachedStocks.firstWhereOrNull(
            (stock) => stock.symbol == stockWebsocketModel.symbol);
        if (stockEntity != null) {
          stockEntity =
              stockEntity.updatePrice(stockWebsocketModel.currentPrice);
          cachedStocks = cachedStocks
              .map((s) => s.symbol == stockEntity!.symbol ? stockEntity : s)
              .toList();
          var updatedStocksData = stocksList
              .map((s) => s.symbol == stockEntity!.symbol ? stockEntity : s)
              .toList();
          return Right(updatedStocksData);
        } else {
          return const Left(EmptyDataFailure());
        }
      });
    } else {
      return const Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<SymbolEntity>>> search(String query) async {
    if (await networkInfo.isConnected) {
      watchlistSymbols =
          watchListLocalDataSource.getWatchlist().getOrElse(() => []);
      final response = await symbolsRemoteDataSource.search(query);
      return response.fold((failure) => Left(failure), (symbols) {
        if (watchlistSymbols.isNotEmpty) {
          for (String symbol in watchlistSymbols) {
            symbols
                .firstWhereOrNull((element) => element.symbol == symbol)
                ?.isWatchlisted = true;
          }
        }
        return Right(symbols);
      });
    } else {
      return const Left(OfflineFailure());
    }
  }
}
