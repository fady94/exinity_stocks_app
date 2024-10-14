part of 'stocks_bloc.dart';

sealed class StocksState extends Equatable {
  const StocksState();

  @override
  List<Object> get props => [];
}

final class StocksInitial extends StocksState {}

final class StocksLoading extends StocksState {}

final class UpdatingStocks extends StocksState {
  final List<StockEntity> stocks;

  const UpdatingStocks({required this.stocks});
}

final class StocksLoaded extends StocksState {
  final List<StockEntity> stocks;

  const StocksLoaded({required this.stocks});
}

final class StocksFailed extends StocksState {
  final Failure? failure;
  const StocksFailed({this.failure});
}
