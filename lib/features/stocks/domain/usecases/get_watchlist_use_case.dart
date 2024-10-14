import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/use_case.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';

class GetWatchlistUseCase extends UseCase<List<String>, NoParams> {
  final StockRepository stockRepository;

  GetWatchlistUseCase(this.stockRepository);

  @override
  Either<Failure, List<String>> call(NoParams params) {
    return stockRepository.getWatchlist();
  }
}
