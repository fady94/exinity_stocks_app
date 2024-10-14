import 'package:exinity_app/core/network/cubit/connectivity_cubit.dart';
import 'package:exinity_app/core/services/websocket/bloc/websocket_bloc.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/features/stocks/presentation/pages/home_screen.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

import 'home_screen_test.mocks.dart';

@GenerateMocks([ConnectivityCubit, WebsocketBloc, PopularStocksBloc])
void main() {
  late MockConnectivityCubit mockConnectivityCubit;
  late MockWebsocketBloc mockWebsocketBloc;
  late MockPopularStocksBloc mockPopularStocksBloc;

  setUp(() {
    mockConnectivityCubit = MockConnectivityCubit();
    mockWebsocketBloc = MockWebsocketBloc();
    mockPopularStocksBloc = MockPopularStocksBloc();
    provideDummy<ConnectivityState>(ConnectivityConnected());
    provideDummy<WebsocketState>(WebsocketInitial());
    provideDummy<StocksState>(StocksInitial());
    when(mockConnectivityCubit.state).thenReturn(ConnectivityConnected());
    when(mockConnectivityCubit.stream)
        .thenAnswer((_) => Stream<ConnectivityState>.empty());
    when(mockWebsocketBloc.state).thenReturn(WebsocketInitial());
    when(mockWebsocketBloc.stream)
        .thenAnswer((_) => Stream<WebsocketState>.empty());
    when(mockPopularStocksBloc.state).thenReturn(StocksInitial());
    when(mockPopularStocksBloc.stream)
        .thenAnswer((_) => Stream<StocksState>.empty());
  });

  testWidgets('HomeScreen displays title and search button',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>.value(value: mockConnectivityCubit),
          BlocProvider<WebsocketBloc>.value(value: mockWebsocketBloc),
          BlocProvider<PopularStocksBloc>.value(value: mockPopularStocksBloc),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );

    // Ensure the widget tree is fully built
    await tester.pump();

    // Assert
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('HomeScreen displays no internet connection message when offline',
      (WidgetTester tester) async {
    // Arrange
    when(mockConnectivityCubit.state).thenReturn(ConnectivityDisconnected());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>.value(value: mockConnectivityCubit),
          BlocProvider<WebsocketBloc>.value(value: mockWebsocketBloc),
          BlocProvider<PopularStocksBloc>.value(value: mockPopularStocksBloc),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );

    // Ensure the widget tree is fully built
    await tester.pump();

    // Assert
    expect(find.text('No internet connection'), findsOneWidget);
  });

  testWidgets('HomeScreen displays popular stocks when loaded',
      (WidgetTester tester) async {
    // Arrange
    when(mockPopularStocksBloc.state).thenReturn(StocksLoaded(stocks: [
      StockEntity(
        symbolEntity: SymbolEntity(
          displaySymbol: 'AAPL',
          description: 'Apple Inc.',
          currency: 'USD',
          symbol: 'AAPL',
          figi: 'BBG000B9XRY4',
        ),
        changePercentage: 10,
        lastClosePrice: 147,
        currentPrice: 150.0,
        symbol: 'AAPL',
      ),
      StockEntity(
        symbolEntity: SymbolEntity(
          displaySymbol: 'GOOGL',
          description: 'Alphabet Inc.',
          currency: 'USD',
          symbol: 'GOOGL',
          figi: 'BBG000B9XRY4',
        ),
        changePercentage: 5,
        lastClosePrice: 247,
        currentPrice: 250.0,
        symbol: 'GOOGL',
      ),
    ]));

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>.value(value: mockConnectivityCubit),
          BlocProvider<WebsocketBloc>.value(value: mockWebsocketBloc),
          BlocProvider<PopularStocksBloc>.value(value: mockPopularStocksBloc),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );

    // Ensure the widget tree is fully built
    await tester.pump();

    // Assert
    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('GOOGL'), findsOneWidget);
  });

  testWidgets('HomeScreen handles WebSocket connection states',
      (WidgetTester tester) async {
    // Arrange
    when(mockWebsocketBloc.state).thenReturn(WebsocketConnected());

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>.value(value: mockConnectivityCubit),
          BlocProvider<WebsocketBloc>.value(value: mockWebsocketBloc),
          BlocProvider<PopularStocksBloc>.value(value: mockPopularStocksBloc),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const HomeScreen(),
        ),
      ),
    );

    // Ensure the widget tree is fully built
    await tester.pump();

    // Assert
    // expect(find.text('WebSocket Connected'), findsOneWidget);
    expect(find.text('Price Ticker Connected'), findsOneWidget);
  });
}
