import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/usecase/use_case.dart';
import 'package:exinity_app/features/stocks/data/repositories/stock_repository_impl.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_all_symbols_use_case.dart';

import 'get_all_symbols_use_case_test.mocks.dart';

@GenerateMocks([StockRepositoryImpl])
void main() {
  late GetAllSymbolsUseCase getAllSymbolsUseCase;
  late MockStockRepositoryImpl mockStockRepository;
  setUp(() {
    mockStockRepository = MockStockRepositoryImpl();
    getAllSymbolsUseCase =
        GetAllSymbolsUseCase(stockRepository: mockStockRepository);
  });

  group(
    'get_all_symbols_use_case_test',
    () {
      final List<SymbolEntity> tSymbols = [
        SymbolEntity(
          currency: "USD",
          description: "Apple Inc.",
          displaySymbol: "AAPL",
          symbol: "AAPL",
          figi: "figi",
        ),
      ];

      final List<SymbolEntity> tSymbolsEmpty = [];
      test(
        'should return a list of symbols',
        () async {
          // arrange
          when(mockStockRepository.getAllSymbols())
              .thenAnswer((_) async => Right(tSymbols));
          // act
          final result = await getAllSymbolsUseCase(NoParams());
          // assert
          expect(result, isA<Right>());
          verify(mockStockRepository.getAllSymbols());
          verifyNoMoreInteractions(mockStockRepository);
        },
      );

      test(
        'should return an empty list of symbols',
        () async {
          // arrange
          when(mockStockRepository.getAllSymbols())
              .thenAnswer((_) async => Right(tSymbolsEmpty));
          // act
          final result = await getAllSymbolsUseCase(NoParams());
          // assert
          expect(result, isA<Right>());
          verify(mockStockRepository.getAllSymbols());
          verifyNoMoreInteractions(mockStockRepository);
        },
      );

      test(
        'should return a failure',
        () async {
          // arrange
          when(mockStockRepository.getAllSymbols())
              .thenAnswer((_) async => Left(ServerFailure()));
          // act
          final result = await getAllSymbolsUseCase(NoParams());
          // assert
          expect(result, isA<Left>());
          verify(mockStockRepository.getAllSymbols());
          verifyNoMoreInteractions(mockStockRepository);
        },
      );
    },
  );
}
