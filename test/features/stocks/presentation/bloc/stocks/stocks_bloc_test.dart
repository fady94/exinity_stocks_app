import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_selected_stocks_data_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/stock_update_recieved_use_case.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';

import 'stocks_bloc_test.mocks.dart';

@GenerateMocks([GetSelectedStocksDataUseCase, StockUpdateRecievedUseCase])
void main() {
  late MockGetSelectedStocksDataUseCase mockGetSelectedStocksDataUseCase;
  late MockStockUpdateRecievedUseCase mockStockUpdateRecievedUseCase;
  late PopularStocksBloc stocksBloc;

  setUp(() {
    mockGetSelectedStocksDataUseCase = MockGetSelectedStocksDataUseCase();
    mockStockUpdateRecievedUseCase = MockStockUpdateRecievedUseCase();
    stocksBloc = PopularStocksBloc(
      stockUpdateRecievedUseCase: mockStockUpdateRecievedUseCase,
      getSelectedSymbolsDataUseCase: mockGetSelectedStocksDataUseCase,
    );
  });

  final List<StockEntity> stocks = [
    StockEntity(
        symbol: "AAPL",
        currentPrice: 100,
        lastClosePrice: 90,
        changePercentage: 10,
        symbolEntity: SymbolEntity(
          currency: "USD",
          description: "Apple Inc.",
          displaySymbol: "AAPL",
          symbol: "AAPL",
          figi: "figi",
        )),
  ];

  final initialStocks = [
    StockEntity(
      symbol: "AAPL",
      currentPrice: 150.0,
      lastClosePrice: 90.0,
      changePercentage: 10.0,
      symbolEntity: SymbolEntity(
        currency: "USD",
        description: "Apple Inc.",
        displaySymbol: "AAPL",
        symbol: "AAPL",
        figi: "figi",
      ),
    ),
  ];

  final updatedStocks = [
    StockEntity(
      symbol: "AAPL",
      currentPrice: 155.0, // Updated price
      lastClosePrice: 90.0,
      changePercentage: 10.0,
      symbolEntity: SymbolEntity(
        currency: "USD",
        description: "Apple Inc.",
        displaySymbol: "AAPL",
        symbol: "AAPL",
        figi: "figi",
      ),
    ),
  ];

  tearDown(() {
    stocksBloc.close();
  });

  test('initial state should be StocksInitial', () {
    expect(stocksBloc.state, StocksInitial());
  });

  group('GetStocks Event', () {
    blocTest<StocksBloc, StocksState>(
      'emits [StocksLoading, StocksLoaded] when GetStocks is added and use case returns success',
      build: () {
        // Arrange: Mock the use case to return a Right with a list of initial stocks
        when(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .thenAnswer(
          (_) async => Right<Failure, List<StockEntity>>(initialStocks),
        );
        return stocksBloc;
      },
      act: (bloc) => bloc.add(GetStocks()),
      expect: () => [
        StocksLoading(),
        isA<StocksLoaded>()
            .having(
              (state) => state.stocks.length,
              'stocks length',
              1,
            )
            .having(
              (state) => state.stocks[0].currentPrice,
              'currentPrice',
              150.0,
            ),
      ],
      verify: (_) {
        verify(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .called(1);
        verifyNoMoreInteractions(mockGetSelectedStocksDataUseCase);
      },
    );

    blocTest<StocksBloc, StocksState>(
      'emits [StocksLoading, StocksFailed] when GetStocks is added and use case returns failure',
      build: () {
        // Arrange: Mock the use case to return a Left with a failure
        when(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .thenAnswer(
          (_) async => Left<Failure, List<StockEntity>>(ServerFailure()),
        );
        return stocksBloc;
      },
      act: (bloc) => bloc.add(GetStocks()),
      expect: () => [
        StocksLoading(),
        isA<StocksFailed>().having(
          (state) => state.failure,
          'failure',
          isA<ServerFailure>(),
        ),
      ],
      verify: (_) {
        verify(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .called(1);
        verifyNoMoreInteractions(mockGetSelectedStocksDataUseCase);
      },
    );
  });

  group('WebsocketStockReceived Event', () {
    blocTest<StocksBloc, StocksState>(
      'emits [UpdatingStocks, StocksLoaded] when WebsocketStockReceived is added and use case returns success',
      build: () {
        // Arrange: Mock the initial GetStocks call
        when(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .thenAnswer(
          (_) async => Right<Failure, List<StockEntity>>(initialStocks),
        );

        // Mock the update use case to return updated stocks
        when(mockStockUpdateRecievedUseCase.call(any)).thenAnswer(
          (_) async => Right<Failure, List<StockEntity>>(updatedStocks),
        );

        return stocksBloc;
      },
      act: (bloc) async {
        bloc.add(GetStocks());
        // Ensure the first event is processed before adding the second
        await Future.delayed(Duration.zero);
        bloc.add(WebsocketStockReceived(
          json: '{"c":null,"p":155.0,"s":"AAPL","t":1728843863309,"v":0.00134}',
        ));
      },
      expect: () => [
        StocksLoading(),
        isA<StocksLoaded>().having(
          (state) => state.stocks[0].currentPrice,
          'currentPrice',
          150.0,
        ),
        UpdatingStocks(stocks: initialStocks),
        isA<StocksLoaded>().having(
          (state) => state.stocks[0].currentPrice,
          'updatedPrice',
          155.0,
        ),
      ],
      verify: (_) {
        verify(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .called(1);
        verify(mockStockUpdateRecievedUseCase.call(any)).called(1);
        verifyNoMoreInteractions(mockGetSelectedStocksDataUseCase);
        verifyNoMoreInteractions(mockStockUpdateRecievedUseCase);
      },
    );

    blocTest<StocksBloc, StocksState>(
      'emits [UpdatingStocks, StocksLoaded] when WebsocketStockReceived is added and use case returns failure',
      build: () {
        // Arrange: Mock the initial GetStocks call
        when(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .thenAnswer(
          (_) async => Right<Failure, List<StockEntity>>(initialStocks),
        );

        // Mock the update use case to return a Left with a failure
        when(mockStockUpdateRecievedUseCase.call(any)).thenAnswer(
          (_) async => Left<Failure, List<StockEntity>>(ServerFailure()),
        );

        return stocksBloc;
      },
      act: (bloc) async {
        bloc.add(GetStocks());
        // Ensure the first event is processed before adding the second
        await Future.delayed(Duration.zero);
        bloc.add(WebsocketStockReceived(
          json: '{"c":null,"p":190,"s":"AAPL","t":1728843863309,"v":0.00134}',
        ));
      },
      expect: () => [
        StocksLoading(),
        isA<StocksLoaded>().having(
          (state) => state.stocks[0].currentPrice,
          'currentPrice',
          150.0,
        ),
        UpdatingStocks(stocks: initialStocks),
        isA<StocksLoaded>().having(
          (state) => state.stocks[0].currentPrice,
          'unchangedPrice',
          150.0,
        ),
      ],
      verify: (_) {
        verify(mockGetSelectedStocksDataUseCase.call(StockType.popular))
            .called(1);
        verify(mockStockUpdateRecievedUseCase.call(any)).called(1);
        verifyNoMoreInteractions(mockGetSelectedStocksDataUseCase);
        verifyNoMoreInteractions(mockStockUpdateRecievedUseCase);
      },
    );

    blocTest<StocksBloc, StocksState>(
      'emits nothing when WebsocketStockReceived is added but savedStocks is empty',
      build: () {
        return stocksBloc;
      },
      act: (bloc) => bloc.add(WebsocketStockReceived(
        json: '{"c":null,"p":190,"s":"AAPL","t":1728843863309,"v":0.00134}',
      )),
      expect: () => [],
      verify: (_) {
        verifyZeroInteractions(mockStockUpdateRecievedUseCase);
      },
    );
  });
}
