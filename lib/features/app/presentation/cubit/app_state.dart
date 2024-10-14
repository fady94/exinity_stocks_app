part of 'app_cubit.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => [];
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final bool isNetworkConnected;

  const AppLoaded({required this.isNetworkConnected});
}

class AppFailed extends AppState {
  final Failure failure;
  const AppFailed({required this.failure});
}
