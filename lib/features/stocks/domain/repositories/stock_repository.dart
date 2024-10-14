import 'package:dartz/dartz.dart';
import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/data/models/stock_api_model.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';

abstract class StockRepository {
  Future<Either<Failure, List<SymbolEntity>>> getAllSymbols();

  Either<Failure, List<String>> getWatchlist();

  Either<Failure, bool> addToWatchlist(String symbol);

  Either<Failure, bool> removeFromWatchlist(String symbol);

  Future<Either<Failure, StockApiModel>> getStockInfo(String symbol);

  Future<Either<Failure, List<SymbolEntity>>> search(String query);

  Future<Either<Failure, List<StockEntity>>> getSelectedStocksData(
      StockType stockType);

  Future<Either<Failure, List<StockEntity>>> updateSelectedStocksPrice(
      {required List<StockEntity> stocksList, required dynamic dataReceived});
}
