import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/data/models/stock_websocket_model.dart';

abstract class StockWebsocketRemoteDataSource {
  Either<Failure, StockWebsocketModel> getPriceUpdate(dynamic json);
}

class StockWebsocketRemoteDataSourceImpl
    implements StockWebsocketRemoteDataSource {
  StockWebsocketRemoteDataSourceImpl();

  @override
  Either<Failure, StockWebsocketModel> getPriceUpdate(dynamic json) {
    StockWebsocketModel stockModel;
    if (json['type'] == "trade" && json['data'] != null) {
      var data = json['data'][0];
      stockModel = StockWebsocketModel.fromJson(data);
      return Right(stockModel);
    }
    return const Left(ServerFailure());
  }
}
