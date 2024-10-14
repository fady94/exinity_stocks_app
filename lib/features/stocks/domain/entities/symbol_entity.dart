import 'package:equatable/equatable.dart';

class SymbolEntity extends Equatable {
  final String currency;
  final String symbol;
  final String description;
  final String displaySymbol;
  final String figi;

  const SymbolEntity({
    required this.currency,
    required this.symbol,
    required this.description,
    required this.displaySymbol,
    required this.figi,
  });

  @override
  List<Object?> get props => [symbol, displaySymbol];

  @override
  String toString() {
    return symbol;
  }
}
