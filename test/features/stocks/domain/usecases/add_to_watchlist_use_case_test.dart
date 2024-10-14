import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/data/repositories/stock_repository_impl.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:exinity_app/features/stocks/domain/usecases/add_to_watchlist_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_symbols_use_case_test.mocks.dart';

@GenerateMocks([StockRepositoryImpl])
void main() {
  late AddToWatchlistUseCase addToWatchlistUseCase;
  late MockStockRepositoryImpl mockStockRepository;

  setUp(() {
    mockStockRepository = MockStockRepositoryImpl();
    addToWatchlistUseCase = AddToWatchlistUseCase(mockStockRepository);
  });

  test('should add a symbol to the watchlist', () async {
    // arrange

    when(mockStockRepository.addToWatchlist("AAPL"))
        .thenAnswer((_) => Right(true));
    // act
    final result = addToWatchlistUseCase("AAPL");
    // assert
    expect(result, const Right(true));
    verify(mockStockRepository.addToWatchlist("AAPL"));
    verifyNoMoreInteractions(mockStockRepository);
  });

  test('should return a failure when adding a symbol to the watchlist',
      () async {
    // arrange
    when(mockStockRepository.addToWatchlist("AAPL"))
        .thenAnswer((_) => Left(const BadRequestFailure()));
    // act
    final result = addToWatchlistUseCase("AAPL");
    // assert
    expect(result, const Left(BadRequestFailure()));
    verify(mockStockRepository.addToWatchlist("AAPL"));
    verifyNoMoreInteractions(mockStockRepository);
  });
}
