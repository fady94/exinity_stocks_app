import 'package:dartz/dartz.dart';
import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/future_use_case.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';

class GetSelectedStocksDataUseCase
    extends FutureUseCase<List<StockEntity>,StockType> {
  final StockRepository stockRepository;

  GetSelectedStocksDataUseCase({required this.stockRepository});

  @override
  Future<Either<Failure, List<StockEntity>>> call(StockType params) async {
    return await stockRepository.getSelectedStocksData(params);
  }
}
