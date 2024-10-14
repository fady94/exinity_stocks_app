import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/api/dio_client.dart';
import 'package:exinity_app/core/env/env.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/data/models/stock_api_model.dart';

abstract class StockApiRemoteDataSource {
  Future<Either<Failure, StockApiModel>> getStockInfo(String symbol);
}

class StockApiRemoteDataSourceImpl implements StockApiRemoteDataSource {
  final DioClient dioClient;

  StockApiRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, StockApiModel>> getStockInfo(String symbol) async {
    final response = await dioClient.getRequest("quote",
        queryParameters: {"token": Env.token, "symbol": symbol},
        isIsolate: false,
        converter: (data) => StockApiModel.fromJson(data));
    return response.fold(
        (failure) => Left(failure), (stockInfo) => Right(stockInfo));
  }
}
