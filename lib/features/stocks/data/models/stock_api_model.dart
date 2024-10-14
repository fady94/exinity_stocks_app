import 'package:equatable/equatable.dart';

class StockApiModel extends Equatable {
  final num percentage;
  final num currentPrice;
  final num lastClosePrice;

  const StockApiModel({
    required this.percentage,
    required this.currentPrice,
    required this.lastClosePrice,
  });

  @override
  List<Object?> get props => [percentage, currentPrice, lastClosePrice];

  @override
  String toString() {
    return currentPrice.toString();
  }

  factory StockApiModel.fromJson(Map<String, dynamic> json) {
    return StockApiModel(
      percentage: json['dp'] ?? 0,
      currentPrice: json['c'] ?? 0,
      lastClosePrice: json['pc'] ?? 0,
    );
  }
}
