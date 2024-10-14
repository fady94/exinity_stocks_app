import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:exinity_app/core/api/dio_client.dart';
import 'package:exinity_app/core/local/shared_prefernces_helper.dart';
import 'package:exinity_app/core/network/api_provider.dart';
import 'package:exinity_app/core/network/api_provider_impl.dart';
import 'package:exinity_app/core/network/cubit/connectivity_cubit.dart';
import 'package:exinity_app/core/network/network_info.dart';
import 'package:exinity_app/core/services/websocket/bloc/websocket_bloc.dart';
import 'package:exinity_app/core/services/websocket/web_socket_service.dart';
import 'package:exinity_app/features/stocks/data/datasources/watchlist_local_data_source.dart';
import 'package:exinity_app/features/stocks/domain/usecases/search_use_case.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/search/search_bloc.dart';
import 'package:exinity_app/features/stocks/data/datasources/stock_api_remote_data_source.dart';
import 'package:exinity_app/features/stocks/data/datasources/stock_websocket_remote_data_sourc.dart';
import 'package:exinity_app/features/stocks/data/datasources/symbols_remote_data_source.dart';
import 'package:exinity_app/features/stocks/data/repositories/stock_repository_impl.dart';
import 'package:exinity_app/features/stocks/domain/repositories/stock_repository.dart';
import 'package:exinity_app/features/app/presentation/cubit/app_cubit.dart';
import 'package:exinity_app/features/stocks/domain/usecases/add_to_watchlist_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_all_symbols_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_selected_stocks_data_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/get_watchlist_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/remove_from_watchlist_use_case.dart';
import 'package:exinity_app/features/stocks/domain/usecases/stock_update_recieved_use_case.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //Bloc
  sl.registerFactory<WebsocketBloc>(
      () => WebsocketBloc(webSocketService: sl()));
  sl.registerFactory<PopularStocksBloc>(() => PopularStocksBloc(
      getSelectedSymbolsDataUseCase: sl(), stockUpdateRecievedUseCase: sl()));
  sl.registerFactory<WatchlistStocksBloc>(() => WatchlistStocksBloc(
      getSelectedSymbolsDataUseCase: sl(), stockUpdateRecievedUseCase: sl()));
  sl.registerFactory<SearchBloc>(() => SearchBloc(searchUseCase: sl()));
  sl.registerFactory<WatchlistBloc>(() => WatchlistBloc(
      addToWatchlistUseCase: sl(),
      getWatchlistUseCase: sl(),
      removeFromWatchlistUseCase: sl()));

  // Cubit
  sl.registerFactory<AppCubit>(
      () => AppCubit(getAllSymbols: sl(), networkInfo: sl()));
  sl.registerFactory<ConnectivityCubit>(() => ConnectivityCubit(sl()));

  // Use cases
  sl.registerLazySingleton<GetAllSymbolsUseCase>(
      () => GetAllSymbolsUseCase(stockRepository: sl()));
  sl.registerLazySingleton<GetSelectedStocksDataUseCase>(
      () => GetSelectedStocksDataUseCase(stockRepository: sl()));
  sl.registerLazySingleton(
      () => StockUpdateRecievedUseCase(stockRepository: sl()));
  sl.registerLazySingleton(() => SearchUseCase(stockRepository: sl()));
  sl.registerLazySingleton<GetWatchlistUseCase>(
      () => GetWatchlistUseCase(sl()));
  sl.registerLazySingleton<AddToWatchlistUseCase>(
      () => AddToWatchlistUseCase(sl()));
  sl.registerLazySingleton<RemoveFromWatchlistUseCase>(
      () => RemoveFromWatchlistUseCase(sl()));

  // Repository
  sl.registerLazySingleton<StockRepository>(() => StockRepositoryImpl(
      networkInfo: sl(),
      stockApiRemoteDataSource: sl(),
      symbolsRemoteDataSource: sl(),
      webSocketService: sl(),
      stockWebsocketRemoteDataSource: sl(),
      watchListLocalDataSource: sl()));

  // Data sources
  sl.registerLazySingleton<SymbolsRemoteDataSource>(
      () => SymbolsRemoteDataSourceImpl(
            dioClient: sl(),
          ));
  sl.registerLazySingleton<StockApiRemoteDataSource>(
      () => StockApiRemoteDataSourceImpl(
            dioClient: sl(),
          ));
  sl.registerLazySingleton<StockWebsocketRemoteDataSource>(
      () => StockWebsocketRemoteDataSourceImpl());

  sl.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(preferenceHelper: sl()));

  // Core
  sl.registerLazySingleton<APIProvider>(() => APIProviderImpl());
  sl.registerLazySingleton<DioClient>(() => DioClient(isUnitTest: false));

  // Features

  sl.registerLazySingleton<PreferenceHelper>(() => PreferenceHelper());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // External
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => WebSocketService());
}
