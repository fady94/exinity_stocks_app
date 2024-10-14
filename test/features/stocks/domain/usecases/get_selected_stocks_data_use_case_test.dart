import 'package:dartz/dartz.dart';
import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_selected_stocks_data_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'get_selected_stocks_data_use_case_test.mocks.dart';

@GenerateMocks([StockRepository])
void main() {
  late MockStockRepository mockStockRepository;
  late GetSelectedStocksDataUseCase getSelectedStocksDataUseCase;

  setUp(() {
    mockStockRepository = MockStockRepository();
    getSelectedStocksDataUseCase =
        GetSelectedStocksDataUseCase(stockRepository: mockStockRepository);
  });

  group(
    'get_selected_stocks_data_use_case_test',
    () {
      test(
        'call without error',
        () async {
          // arrange
          when(mockStockRepository.getSelectedStocksData(StockType.popular))
              .thenAnswer((_) async => Right([]));
          // act
          final result = await getSelectedStocksDataUseCase(StockType.popular);
          // assert
          expect(result, isA<Right>());
          verify(mockStockRepository.getSelectedStocksData(StockType.popular));
          verifyNoMoreInteractions(mockStockRepository);
        },
      );

      test(
        'should return error',
        () async {
          // arrange
          when(mockStockRepository.getSelectedStocksData(StockType.popular))
              .thenAnswer((_) async => Left(OfflineFailure()));
          // act
          final result = await getSelectedStocksDataUseCase(StockType.popular);
          // assert
          expect(result, isA<Left>());
          verify(mockStockRepository.getSelectedStocksData(StockType.popular));
          verifyNoMoreInteractions(mockStockRepository);
        },
      );
    },
  );
}
