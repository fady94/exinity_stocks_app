import 'package:equatable/equatable.dart';

class StockWebsocketModel extends Equatable {
  final num currentPrice;
  final String symbol;
  final DateTime timestamp;

  const StockWebsocketModel({
    required this.currentPrice,
    required this.symbol,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [symbol, currentPrice, timestamp];

  @override
  String toString() {
    return currentPrice.toString();
  }

  factory StockWebsocketModel.fromJson(Map<String, dynamic> json) {
    return StockWebsocketModel(
      currentPrice: json['p'],
      symbol: json['s'],
      timestamp: DateTime.now(),
    );
  }
}
