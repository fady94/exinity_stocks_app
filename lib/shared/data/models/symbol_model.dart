import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';

class SymbolModel extends SymbolEntity {
  SymbolModel({
    required super.symbol,
    required super.currency,
    required super.description,
    required super.displaySymbol,
    required super.figi,
  });

  factory SymbolModel.fromJson(Map<String, dynamic> json) {
    return SymbolModel(
      symbol: json['symbol'],
      currency: json['currency'] ?? "USD",
      description: json['description'],
      displaySymbol: json['displaySymbol'],
      figi: json['figi'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'currency': currency,
      'description': description,
      'displaySymbol': displaySymbol,
      'figi': figi,
    };
  }
}
