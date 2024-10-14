import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/network/network_info.dart';
import 'package:exinity_app/core/usecase/use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_all_symbols_use_case.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final GetAllSymbolsUseCase getAllSymbols;
  final NetworkInfo networkInfo;

  AppCubit({
    required this.getAllSymbols,
    required this.networkInfo,
  }) : super(AppInitial());

  void init() {
    emit(AppLoading());
    getAllSymbols(NoParams()).then((result) async {
      result.fold(
        (failure) => emit(AppFailed(failure: failure)),
        (symbols) {
          emit(const AppLoaded(isNetworkConnected: true));
          networkInfo.connectionStatus.listen(
            (isConnected) {
              if (isConnected) {
                emit(const AppLoaded(isNetworkConnected: true));
              } else {
                emit(const AppLoaded(isNetworkConnected: false));
              }
              emit(const AppLoaded(isNetworkConnected: true));
            },
          );
        },
      );
    });
  }
}
