import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exinity_app/features/stocks/presentation/pages/search_screen.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/search/search_bloc.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';

import 'search_screen_test.mocks.dart';

@GenerateMocks([SearchBloc])
void main() {
  late MockSearchBloc mockSearchBloc;

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    provideDummy<SearchState>(SearchInitial());
    when(mockSearchBloc.state).thenReturn(SearchInitial());
    when(mockSearchBloc.stream).thenAnswer((_) => Stream<SearchState>.empty());
  });

  testWidgets('SearchScreen displays search bar and triggers search on input',
      (WidgetTester tester) async {
    // Arrange
    when(mockSearchBloc.state).thenReturn(SearchInitial());

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: BlocProvider<SearchBloc>.value(
          value: mockSearchBloc,
          child: const SearchScreen(),
        ),
      ),
    );

    // Assert
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search Stocks'), findsOneWidget);

    // Act
    await tester.enterText(find.byType(TextField), 'AAPL');
    await tester.pump();

    // Assert
    verify(mockSearchBloc.add(SearchQueryChanged(query: 'AAPL'))).called(1);
  });
}
