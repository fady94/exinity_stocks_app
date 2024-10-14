part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class WatchlistEventInitial extends WatchlistEvent {}

class WatchlistEventAddSymbol extends WatchlistEvent {
  final String symbol;

  WatchlistEventAddSymbol(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class WatchlistEventRemoveSymbol extends WatchlistEvent {
  final String symbol;

  const WatchlistEventRemoveSymbol(this.symbol);

  @override
  List<Object> get props => [symbol];
}

class WatchlistEventLoadSymbols extends WatchlistEvent {}
