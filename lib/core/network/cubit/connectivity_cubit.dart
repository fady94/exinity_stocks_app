import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity _connectivity;

  ConnectivityCubit(this._connectivity) : super(ConnectivityInitial()) {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        emit(ConnectivityDisconnected());
      } else {
        emit(ConnectivityConnected());
      }
    });
  }
}
