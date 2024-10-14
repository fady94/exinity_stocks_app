import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/use_case.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';

class RemoveFromWatchlistUseCase extends UseCase<bool, String> {
  final StockRepository stockRepository;

  RemoveFromWatchlistUseCase(this.stockRepository);

  @override
  Either<Failure, bool> call(String params) {
    return stockRepository.removeFromWatchlist(params);
  }
}
