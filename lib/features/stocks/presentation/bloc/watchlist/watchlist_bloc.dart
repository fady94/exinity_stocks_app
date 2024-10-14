import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exinity_app/core/usecase/use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/add_to_watchlist_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_watchlist_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/remove_from_watchlist_use_case.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistUseCase getWatchlistUseCase;
  final AddToWatchlistUseCase addToWatchlistUseCase;
  final RemoveFromWatchlistUseCase removeFromWatchlistUseCase;

  WatchlistBloc({
    required this.getWatchlistUseCase,
    required this.addToWatchlistUseCase,
    required this.removeFromWatchlistUseCase,
  }) : super(WatchlistInitial()) {
    final List<String> watchlist = [];

    on<WatchlistEvent>((event, emit) {
      if (event is WatchlistEventAddSymbol) {
        emit(WatchlistLoading());
        watchlist.add(event.symbol);
        addToWatchlistUseCase(event.symbol);
        emit(WatchlistLoaded(symbols: watchlist));
      } else if (event is WatchlistEventRemoveSymbol) {
        emit(WatchlistLoading());
        watchlist.remove(event.symbol);
        removeFromWatchlistUseCase(event.symbol);
        emit(WatchlistLoaded(symbols: watchlist));
      } else if (event is WatchlistEventLoadSymbols) {
        emit(WatchlistLoading());
        final result = getWatchlistUseCase(NoParams());
        result.fold(
          (failure) => emit(WatchlistError("Can not load watchlist")),
          (symbols) {
            watchlist.addAll(symbols);
            emit(WatchlistLoaded(symbols: symbols));
          },
        );
      }
    });
  }
}
