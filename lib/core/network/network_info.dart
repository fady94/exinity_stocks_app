import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<bool> get connectionStatus; // Add this line
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  NetworkInfoImpl(this.connectionChecker) {
    _startListening(); // Start listening for connection changes
  }

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;

  @override
  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  void _startListening() {
    // Listen for connection status changes
    connectionChecker.onStatusChange.listen((status) {
      _connectionStatusController
          .add(status == InternetConnectionStatus.connected);
    });
  }
}
