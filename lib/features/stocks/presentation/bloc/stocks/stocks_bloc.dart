import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exinity_app/const/constants.dart';
import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_selected_stocks_data_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/stock_update_recieved_use_case.dart';

part 'stocks_event.dart';
part 'stocks_state.dart';

abstract class StocksBloc extends Bloc<StocksEvent, StocksState> {
  final GetSelectedStocksDataUseCase getSelectedSymbolsDataUseCase;
  final StockUpdateRecievedUseCase stockUpdateRecievedUseCase;
  final StockType stockType;

  List<StockEntity> savedStocks = [];
  List<String> selectedSymbols = [];

  StocksBloc(
      {required this.getSelectedSymbolsDataUseCase,
      required this.stockUpdateRecievedUseCase,
      required this.stockType})
      : super(StocksInitial()) {
    if (stockType == StockType.popular) {
      selectedSymbols = Constants.popularStocks;
    }
    on<GetStocks>((event, emit) async {
      emit(StocksLoading());
      var response = await getSelectedSymbolsDataUseCase(stockType);
      response.fold(
        (failure) => emit(StocksFailed(failure: failure)),
        (stocks) {
          savedStocks = stocks;
          emit(StocksLoaded(stocks: stocks));
        },
      );
    });
    

    on<WebsocketStockReceived>((event, emit) async {
      if (savedStocks.isEmpty) return;
      emit(UpdatingStocks(stocks: savedStocks));
      var updatedStocks = await stockUpdateRecievedUseCase(
        StockUpdateRecievedUseCaseParams(
          selectedStocks: savedStocks,
          dataReceived: event.json,
        ),
      );
      updatedStocks.fold(
        (failure) => emit(StocksLoaded(stocks: savedStocks)),
        (updatedStocks) {
          savedStocks = updatedStocks;
          emit(StocksLoaded(stocks: savedStocks));
        },
      );
    });
  }
}
