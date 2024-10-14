import 'dart:async';
import 'dart:io';

import 'package:exinity_app/core/env/env.dart';

class WebSocketService {
  WebSocket? _webSocket;
  final StreamController<void> _disconnectionController =
      StreamController.broadcast();

  List<String> subscribedSymbols = [];

  final int maxRetries = 5; // Maximum number of retries
  final Duration retryDelay = const Duration(seconds: 5);

  Future<void> connect() async {
    int attempt = 0;

    while (attempt < maxRetries) {
      try {
        _webSocket = await WebSocket.connect(
                Uri.parse("${Env.webSocketUrl}?token=${Env.token}").toString())
            .timeout(const Duration(seconds: 5));

        // Successfully connected, re-subscribe to symbols
        if (subscribedSymbols.isNotEmpty) {
          for (var symbol in subscribedSymbols) {
            subscribeToSymbol(symbol);
          }
        }

        // Listen for disconnection
        _webSocket!.done.then((_) {
          _onDisconnect();
        });

        return; // Exit the loop on successful connection
      } catch (e) {
        attempt++;
        if (attempt < maxRetries) {
          await Future.delayed(retryDelay);
        }
      }
    }

    // Handle failure, e.g., emit an error state or notify the UI
  }

  Stream<dynamic> get messages {
    if (_webSocket == null) {
      throw Exception("WebSocket not initialized. Please connect first.");
    }
    return _webSocket!.asBroadcastStream();
  }

  Stream<void> get onDisconnect => _disconnectionController.stream;

  void send(String message) {
    if (_webSocket != null) {
      print('Sending message: $message');
      _webSocket!.add(message);
    }
  }

  Future<void> close() async {
    await _webSocket?.close();
    _webSocket = null; // Reset after closing
  }

  void subscribeToSymbol(String symbol) {
    if (!subscribedSymbols.contains(symbol)) {
      subscribedSymbols.add(symbol);
    }
    send('{"type":"subscribe","symbol":"$symbol"}');
  }

  void unsubscribeFromSymbol(String symbol) {
    if (subscribedSymbols.contains(symbol)) {
      subscribedSymbols.remove(symbol);
    }
    send('{"type":"unsubscribe","symbol":"$symbol"}');
  }

  void _onDisconnect() {
    print("WebSocket disconnected");
    _disconnectionController.add(null); // Notify listeners
  }
}
