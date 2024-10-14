import 'package:exinity_app/core/network/cubit/connectivity_cubit.dart';
import 'package:exinity_app/core/routing/app_router.dart';
import 'package:exinity_app/core/services/websocket/bloc/websocket_bloc.dart';
import 'package:exinity_app/core/theme/theme_data.dart';
import 'package:exinity_app/core/theme/util.dart';
import 'package:exinity_app/features/app/presentation/cubit/app_cubit.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/search/search_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'generated/l10n.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Retrieves the default theme for the platform
    //TextTheme textTheme = Theme.of(context).textTheme;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Alike Angular", "Almarai");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityCubit>(
            create: (context) => di.sl<ConnectivityCubit>(),
          ),
          BlocProvider(create: (context) => di.sl<WebsocketBloc>()),
          BlocProvider(create: (context) => di.sl<AppCubit>()),
          BlocProvider(create: (context) => di.sl<WatchlistBloc>()),
          BlocProvider(create: (context) => di.sl<PopularStocksBloc>()),
          BlocProvider(create: (context) => di.sl<WatchlistStocksBloc>()),
          BlocProvider(create: (context) => di.sl<SearchBloc>()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(430, 932),
          minTextAdapt: true,
          child: MaterialApp.router(
            locale: const Locale('en'),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'Exinity App',
            theme:
                brightness == Brightness.light ? theme.light() : theme.dark(),
            routerConfig: AppRouter.router,
          ),
        ));
  }
}
