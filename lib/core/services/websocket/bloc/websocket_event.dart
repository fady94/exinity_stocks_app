part of 'websocket_bloc.dart';

sealed class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object> get props => [];
}

class ConnectWebsocketEvent extends WebsocketEvent {}

class DisconnectWebsocketEvent extends WebsocketEvent {}

class SubscribeToStockEvent extends WebsocketEvent {
  final String symbol;

  const SubscribeToStockEvent({required this.symbol});

  @override
  List<Object> get props => [symbol];
}

class UnsubscribeToStockEvent extends WebsocketEvent {
  final String symbol;

  const UnsubscribeToStockEvent({required this.symbol});

  @override
  List<Object> get props => [symbol];
}

class WebsocketDataReceivedEvent extends WebsocketEvent {
  final String jsonString;

  const WebsocketDataReceivedEvent({required this.jsonString});

  @override
  List<Object> get props => [jsonString];
}
