import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/future_use_case.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';

class SearchUseCase extends FutureUseCase<List<SymbolEntity>, String> {
  final StockRepository stockRepository;

  SearchUseCase({required this.stockRepository});

  @override
  Future<Either<Failure, List<SymbolEntity>>> call(String params) async {
    return await stockRepository.search(params);
  }
} 