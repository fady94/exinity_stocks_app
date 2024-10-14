import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:exinity_app/features/stocks/presentation/widgets/stock_tile_widget.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';

void main() {
  testWidgets('StockTileWidget displays stock information',
      (WidgetTester tester) async {
    // Arrange
    final stock = StockEntity(
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
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StockTileWidget(stock: stock),
        ),
      ),
    );

    // Assert
    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('Apple Inc.'), findsOneWidget);
    expect(find.text('150.0'), findsOneWidget);
    expect(find.text('10%'), findsOneWidget);
  });
}
