part of 'stocks_bloc.dart';

sealed class StocksEvent extends Equatable {
  const StocksEvent();

  @override
  List<Object> get props => [];
}

class GetStocks extends StocksEvent {}

class WebsocketStockReceived extends StocksEvent {
  final dynamic json;

  const WebsocketStockReceived({required this.json});

  @override
  List<Object> get props => [json];
}
