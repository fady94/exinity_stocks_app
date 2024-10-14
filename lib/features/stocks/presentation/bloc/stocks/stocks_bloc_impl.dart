import 'package:exinity_app/const/enums.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_selected_stocks_data_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/stock_update_recieved_use_case.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc.dart';

class PopularStocksBloc extends StocksBloc {
  final GetSelectedStocksDataUseCase getSelectedSymbolsDataUseCase;
  final StockUpdateRecievedUseCase stockUpdateRecievedUseCase;
  PopularStocksBloc(
      {required this.getSelectedSymbolsDataUseCase,
      required this.stockUpdateRecievedUseCase})
      : super(
            stockType: StockType.popular,
            getSelectedSymbolsDataUseCase: getSelectedSymbolsDataUseCase,
            stockUpdateRecievedUseCase: stockUpdateRecievedUseCase);
}

class WatchlistStocksBloc extends StocksBloc {
  final GetSelectedStocksDataUseCase getSelectedSymbolsDataUseCase;
  final StockUpdateRecievedUseCase stockUpdateRecievedUseCase;
  WatchlistStocksBloc(
      {required this.getSelectedSymbolsDataUseCase,
      required this.stockUpdateRecievedUseCase})
      : super(
            stockType: StockType.watchList,
            getSelectedSymbolsDataUseCase: getSelectedSymbolsDataUseCase,
            stockUpdateRecievedUseCase: stockUpdateRecievedUseCase);
}
