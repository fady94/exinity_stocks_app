import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exinity_app/core/services/websocket/web_socket_service.dart';
import 'package:exinity_app/features/stocks/data/models/stock_websocket_model.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final WebSocketService webSocketService;
  WebsocketBloc({required this.webSocketService}) : super(WebsocketInitial()) {
    webSocketService.onDisconnect.listen((_) {
      add(DisconnectWebsocketEvent()); // Trigger disconnection event
    });

    on<ConnectWebsocketEvent>((event, emit) async {
      try {
        emit(WebsocketConnecting());
        await webSocketService.connect();
        emit(WebsocketConnected());
        await for (var message in webSocketService.messages) {
          var json = jsonDecode(message);
          if (message.contains("trade"))
            emit(WebsocketDataReceived(json: json));
        }
      } catch (e) {
        emit(WebsocketError(
            message: "Error connecting to websocket $e.toString()"));
      }
    });

    on<DisconnectWebsocketEvent>((event, emit) {
      webSocketService.close();
      emit(WebsocketDisconnected());
    });

    on<SubscribeToStockEvent>((event, emit) {
      webSocketService.subscribeToSymbol(event.symbol);
    });

    on<UnsubscribeToStockEvent>((event, emit) {
      webSocketService.unsubscribeFromSymbol(event.symbol);
    });
  }
}
