import 'package:equatable/equatable.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';

class StockEntity extends Equatable {
  final SymbolEntity symbolEntity;
  final String symbol;
  final num currentPrice;
  final num lastClosePrice;
  final num changePercentage;

  const StockEntity({
    required this.symbolEntity,
    required this.symbol,
    required this.currentPrice,
    required this.lastClosePrice,
    required this.changePercentage,
  });

  @override
  List<Object?> get props => [symbol, lastClosePrice];

  @override
  String toString() {
    return symbol;
  }

  updatePrice(num newPrice) {
    return StockEntity(
      symbolEntity: symbolEntity,
      symbol: symbol,
      currentPrice: newPrice,
      lastClosePrice: lastClosePrice,
      changePercentage: ((newPrice - lastClosePrice) / lastClosePrice) * 100,
    );
  }
}
