import 'package:dartz/dartz.dart';
import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/local/shared_prefernces_helper.dart';
import 'package:exinity_app/core/network/network_info.dart';
import 'package:exinity_app/core/services/websocket/web_socket_service.dart';
import 'package:exinity_app/features/stocks/data/datasources/stock_api_remote_data_source.dart';
import 'package:exinity_app/features/stocks/data/datasources/stock_websocket_remote_data_sourc.dart';
import 'package:exinity_app/features/stocks/data/datasources/symbols_remote_data_source.dart';
import 'package:exinity_app/features/stocks/data/datasources/watchlist_local_data_source.dart';
import 'package:exinity_app/features/stocks/data/models/stock_api_model.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/shared/data/models/symbol_model.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:exinity_app/features/stocks/data/repositories/stock_repository_impl.dart';

import 'stock_repository_impl_test.mocks.dart';

@GenerateMocks([
  StockApiRemoteDataSource,
  SymbolsRemoteDataSource,
  StockWebsocketRemoteDataSource,
  NetworkInfo,
  WebSocketService,
  WatchlistLocalDataSource
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late StockRepositoryImpl stockRepositoryImpl;
  late StockApiRemoteDataSource mockStockApiRemoteDataSource;
  late SymbolsRemoteDataSource mockSymbolsRemoteDataSource;
  late StockWebsocketRemoteDataSource mockStockWebsocketRemoteDataSource;
  late NetworkInfo mockNetworkInfo;
  late WebSocketService mockWebSocketService;
  late WatchlistLocalDataSource mockWatchListLocalDataSource;

  setUp(() async {
    mockStockApiRemoteDataSource = MockStockApiRemoteDataSource();
    mockSymbolsRemoteDataSource = MockSymbolsRemoteDataSource();
    mockStockWebsocketRemoteDataSource = MockStockWebsocketRemoteDataSource();
    mockWatchListLocalDataSource = MockWatchlistLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockWebSocketService = MockWebSocketService();
    stockRepositoryImpl = StockRepositoryImpl(
        watchListLocalDataSource: mockWatchListLocalDataSource,
        stockApiRemoteDataSource: mockStockApiRemoteDataSource,
        symbolsRemoteDataSource: mockSymbolsRemoteDataSource,
        stockWebsocketRemoteDataSource: mockStockWebsocketRemoteDataSource,
        networkInfo: mockNetworkInfo,
        webSocketService: mockWebSocketService);
  });

  final List<SymbolModel> symbols = [
    SymbolModel(
      currency: "USD",
      description: "Apple Inc.",
      displaySymbol: "AAPL",
      symbol: "AAPL",
      figi: "figi",
    ),
    SymbolModel(
      currency: "USD",
      description: "Amazon Inc.",
      displaySymbol: "AMZN",
      symbol: "AMZN",
      figi: "figi",
    ),
  ];

  final StockApiModel aaplStockInfo =
      StockApiModel(currentPrice: 100, lastClosePrice: 90, percentage: 10);

  final List<StockEntity> stocks = [
    StockEntity(
        symbol: "AAPL",
        currentPrice: 100,
        lastClosePrice: 90,
        changePercentage: 10,
        symbolEntity: SymbolModel(
          currency: "USD",
          description: "Apple Inc.",
          displaySymbol: "AAPL",
          symbol: "AAPL",
          figi: "figi",
        )),
  ];

  group(
    'get_all_symbols',
    () {
      test(
        'No internet is connected',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => Right([]));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));
          // act
          final result = await stockRepositoryImpl.getAllSymbols();
          // assert
          expect(result, const Left(OfflineFailure()));
        },
      );

      test(
        'should return empty list',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(['AAPL']));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => const Right([]));
          // act
          final result = await stockRepositoryImpl.getAllSymbols();
          // assert
          expect(result, const Left(EmptyDataFailure()));
        },
      );

      test(
        'should return a list of symbols',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(["AAPL"]));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));
          // act
          final result = await stockRepositoryImpl.getAllSymbols();
          // assert
          expect(result, Right(symbols));
        },
      );

      test(
        'should return error when fetch is not successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Left(LogicFailure()));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await stockRepositoryImpl.getAllSymbols();
          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );

  group(
    'get_watchlist',
    () {
      test(
        'should return a list of symbols',
        () async {
          // arrange
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(["AAPL"]));
          // act
          final result = stockRepositoryImpl.getWatchlist();
          // assert
          expect(result, const Right(["AAPL"]));
        },
      );

      test(
        'should return empty list',
        () async {
          List<String> watchlist = [];
          // arrange
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => Right(watchlist));
          // act
          final result = stockRepositoryImpl.getWatchlist();
          // assert
          expect(result, Right(watchlist));
        },
      );

      test(
        'should return error when fetch is not successful',
        () async {
          // arrange
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Left(LogicFailure()));
          // act
          final result = stockRepositoryImpl.getWatchlist();
          // assert
          expect(result, const Left(LogicFailure()));
        },
      );
    },
  );

  group(
    'add_to_watchlist',
    () {
      test(
        'should add a symbol to the watchlist',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(['GOOGL']));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          await stockRepositoryImpl.getAllSymbols();

          // arrange
          when(mockWatchListLocalDataSource.addToWatchlist("AAPL"))
              .thenAnswer((_) => Right(true));

          // act
          final result = stockRepositoryImpl.addToWatchlist("AAPL");
          // assert
          expect(result, const Right(true));
        },
      );

      test(
        'symbol not found in symbolsList',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(['AMZN']));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          await stockRepositoryImpl.getAllSymbols();

          // arrange
          when(mockWatchListLocalDataSource.addToWatchlist("GOOGL"))
              .thenAnswer((_) => Right(true));

          // act
          final result = stockRepositoryImpl.addToWatchlist("GOOGL");
          // assert
          expect(result, const Left(SymbolNotFound(symbol: "GOOGL")));
        },
      );

      test(
        'should return a failure when adding a symbol to the watchlist',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(['GOOGL']));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          await stockRepositoryImpl.getAllSymbols();
          // arrange
          when(mockWatchListLocalDataSource.addToWatchlist("AAPL"))
              .thenAnswer((_) => const Left(LogicFailure()));
          // act
          final result = stockRepositoryImpl.addToWatchlist("AAPL");
          // assert
          expect(result, const Left(LogicFailure()));
        },
      );
    },
  );

  group(
    'remove_from_watchlist',
    () {
      test(
        'should remove a symbol from the watchlist',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(['AAPL']));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          await stockRepositoryImpl.getAllSymbols();

          // arrange
          when(mockWatchListLocalDataSource.removeFromWatchlist("AAPL"))
              .thenAnswer((_) => Right(true));

          // act
          final result = stockRepositoryImpl.removeFromWatchlist("AAPL");
          // assert
          expect(result, const Right(true));
        },
      );

      test(
        'should return a failure when removing a symbol from the watchlist',
        () async {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => const Right(['AAPL']));
          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          await stockRepositoryImpl.getAllSymbols();
          // arrange
          when(mockWatchListLocalDataSource.removeFromWatchlist("AAPL"))
              .thenAnswer((_) => const Left(LogicFailure()));
          // act
          final result = stockRepositoryImpl.removeFromWatchlist("AAPL");
          // assert
          expect(result, const Left(LogicFailure()));
        },
      );
    },
  );

  group(
    'get_stock_info',
    () {
      test(
        'should return a symbol',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockStockApiRemoteDataSource.getStockInfo("AAPL"))
              .thenAnswer((_) async => Right(aaplStockInfo));
          // act
          final result = await stockRepositoryImpl.getStockInfo("AAPL");
          // assert
          expect(result, Right(aaplStockInfo));
        },
      );

      test(
        'should return failure',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockStockApiRemoteDataSource.getStockInfo("AAPL"))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await stockRepositoryImpl.getStockInfo("AAPL");
          // assert
          expect(result, Left(ServerFailure()));
          verify(mockStockApiRemoteDataSource.getStockInfo("AAPL"));
          verifyNoMoreInteractions(mockStockApiRemoteDataSource);
        },
      );
    },
  );

  group(
    'get_selected_stocks_data',
    () {
      test(
        'should return a list of stocks',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => Right([]));

          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          when(mockStockApiRemoteDataSource.getStockInfo("AAPL"))
              .thenAnswer((_) async => Right(aaplStockInfo));

          // act
          await stockRepositoryImpl.getAllSymbols();
          final result = await stockRepositoryImpl
              .getSelectedStocksData(StockType.popular);
          // assert
          expect(result, isA<Right>());
        },
      );

      test(
        'should return error when fetch is not successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => Right([]));

          when(mockSymbolsRemoteDataSource.getAllSymbols())
              .thenAnswer((_) async => Right(symbols));

          when(mockStockApiRemoteDataSource.getStockInfo("AAPL"))
              .thenAnswer((_) async => Right(aaplStockInfo));

          // act
          await stockRepositoryImpl.getAllSymbols();
          final result = await stockRepositoryImpl
              .getSelectedStocksData(StockType.popular);
          // assert
          expect(result, Left(OfflineFailure()));
        },
      );
    },
  );

  group(
    'search',
    () {
      test(
        'should return a list of symbols',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => Right([]));
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSymbolsRemoteDataSource.search("AAPL"))
              .thenAnswer((_) async => Right(symbols));
          // act
          final result = await stockRepositoryImpl.search("AAPL");
          // assert
          expect(result, Right(symbols));
        },
      );

      test(
        'should return error when fetch is not successful',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockWatchListLocalDataSource.getWatchlist())
              .thenAnswer((_) => Right([]));
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockSymbolsRemoteDataSource.search("AAPL"))
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await stockRepositoryImpl.search("AAPL");
          // assert
          expect(result, Left(ServerFailure()));
        },
      );
    },
  );
}
