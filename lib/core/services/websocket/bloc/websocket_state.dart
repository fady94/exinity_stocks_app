part of 'websocket_bloc.dart';

sealed class WebsocketState extends Equatable {
  const WebsocketState();

  @override
  List<Object> get props => [];
}

final class WebsocketInitial extends WebsocketState {}

final class WebsocketConnecting extends WebsocketState {}

final class WebsocketConnected extends WebsocketState {}

final class WebsocketDisconnected extends WebsocketState {}

final class WebsocketSubscribed extends WebsocketState {
  final StockWebsocketModel stockWebsocketModel;

  const WebsocketSubscribed({required this.stockWebsocketModel});

  @override
  List<Object> get props => [stockWebsocketModel];
}

final class WebsocketUnsubscribed extends WebsocketState {
  final String symbol;

  const WebsocketUnsubscribed({required this.symbol});

  @override
  List<Object> get props => [symbol];
}

final class WebsocketDataReceived extends WebsocketState {
  final dynamic json;

  const WebsocketDataReceived({required this.json});

  @override
  List<Object> get props => [json];
}

final class WebsocketError extends WebsocketState {
  final String message;

  const WebsocketError({required this.message});

  @override
  List<Object> get props => [message];
}

final class WebsocketLoading extends WebsocketState {}
