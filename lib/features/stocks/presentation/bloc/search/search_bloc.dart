import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exinity_app/features/stocks/domain/usecases/search_use_case.dart';
import 'package:exinity_app/shared/domain/entities/symbol_entity.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchUseCase searchUseCase;
  SearchBloc({required this.searchUseCase}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchQueryChanged) {
        emit(SearchLoading());
        final result = await searchUseCase(event.query);
        result.fold(
          (failure) => emit(SearchFailed()),
          (symbols) => emit(SearchLoaded(symbols: symbols)),
        );
      }
    }, transformer: restartable());

    on<SearchQueryCleared>((event, emit) {
      emit(SearchInitial());
    });
  }
}
