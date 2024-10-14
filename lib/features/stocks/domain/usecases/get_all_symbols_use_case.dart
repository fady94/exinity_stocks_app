import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/future_use_case.dart';
import 'package:exinity_app/core/usecase/use_case.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';

class GetAllSymbolsUseCase extends FutureUseCase<List<SymbolEntity>, NoParams> {
  final StockRepository stockRepository;

  GetAllSymbolsUseCase({required this.stockRepository});

  @override
  Future<Either<Failure, List<SymbolEntity>>> call(NoParams params) async {
    return await stockRepository.getAllSymbols();
  }
}
