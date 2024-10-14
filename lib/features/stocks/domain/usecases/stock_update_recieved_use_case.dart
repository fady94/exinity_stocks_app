import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/future_use_case.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';

class StockUpdateRecievedUseCase
    extends FutureUseCase<List<StockEntity>, StockUpdateRecievedUseCaseParams> {
  final StockRepository stockRepository;

  StockUpdateRecievedUseCase({required this.stockRepository});

  @override
  Future<Either<Failure, List<StockEntity>>> call(
      StockUpdateRecievedUseCaseParams params) async {
    return await stockRepository.updateSelectedStocksPrice(
      stocksList: params.selectedStocks,
      dataReceived: params.dataReceived,
    );
  }
}

class StockUpdateRecievedUseCaseParams {
  final List<StockEntity> selectedStocks;
  final dynamic dataReceived;

  StockUpdateRecievedUseCaseParams(
      {required this.selectedStocks, required this.dataReceived});
}
