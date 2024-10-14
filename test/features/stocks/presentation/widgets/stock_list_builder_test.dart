import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exinity_app/features/stocks/presentation/widgets/stock_list_builder.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';

void main() {
  testWidgets('StockListBuilder displays a list of stocks',
      (WidgetTester tester) async {
    // Arrange
    final stocks = [
      StockEntity(
        symbolEntity: SymbolEntity(
          displaySymbol: 'AAPL',
          description: 'Apple Inc.',
          currency: 'USD',
          symbol: 'AAPL',
          figi: 'BBG000B9XRY4',
        ),
        changePercentage: 10,
        lastClosePrice: 40,
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
        lastClosePrice: 50,
        currentPrice: 200.0,
        symbol: 'GOOGL',
      ),
    ];

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StockListBuilder(
            stocks: stocks,
            isDismissable: false,
            onDismissed: (sym) {},
          ),
        ),
      ),
    );

    // Assert
    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('Apple Inc.'), findsOneWidget);
    expect(find.text('GOOGL'), findsOneWidget);
    expect(find.text('Alphabet Inc.'), findsOneWidget);
  });

  testWidgets('StockListBuilder allows dismissing items',
      (WidgetTester tester) async {
    // Arrange
    final stocks = [
      StockEntity(
        symbolEntity: SymbolEntity(
          displaySymbol: 'AAPL',
          description: 'Apple Inc.',
          currency: 'USD',
          symbol: 'AAPL',
          figi: 'BBG000B9XRY4',
        ),
        changePercentage: 10,
        lastClosePrice: 40,
        currentPrice: 150.0,
        symbol: 'AAPL',
      ),
    ];

    bool dismissed = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StockListBuilder(
            stocks: stocks,
            isDismissable: true,
            onDismissed: (sym) {
              dismissed = true;
            },
          ),
        ),
      ),
    );

    // Swipe to dismiss the item
    await tester.drag(find.text('AAPL'), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    // Assert
    expect(dismissed, isTrue);
    expect(find.text('AAPL'), findsNothing);
  });
}
