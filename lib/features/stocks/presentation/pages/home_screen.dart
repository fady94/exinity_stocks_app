import 'package:exinity_app/core/network/cubit/connectivity_cubit.dart';
import 'package:exinity_app/core/resources/colors.dart';
import 'package:exinity_app/core/resources/images.dart';
import 'package:exinity_app/core/routing/app_routes.dart';
import 'package:exinity_app/core/services/websocket/bloc/websocket_bloc.dart';
import 'package:exinity_app/features/app/presentation/cubit/app_cubit.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/pages/stock_lists/popular_stocks_screen.dart';
import 'package:exinity_app/features/stocks/presentation/pages/stock_lists/watchlist_stocks_screen.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectivityCubit, ConnectivityState>(
      listener: (context, connectionState) {
        if (connectionState is ConnectivityDisconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.red,
                content: Center(
                  child: Text(
                    'No internet connection',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                )),
          );
        }
      },
      builder: (context, state) {
        return DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    S.of(context).title,
                    style: const TextStyle(
                        fontSize: 22,
                        color: ColorManager.primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        context.pushNamed(AppRoutes.searchScreen.name);
                      },
                    ),
                  ],
                  centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      BlocConsumer<WebsocketBloc, WebsocketState>(
                        listener: (context, state) {
                          if (state is WebsocketDataReceived) {
                            context
                                .read<PopularStocksBloc>()
                                .add(WebsocketStockReceived(json: state.json));
                            context
                                .read<WatchlistStocksBloc>()
                                .add(WebsocketStockReceived(json: state.json));
                          }
                        },
                        builder: (context, state) {
                          if (state is WebsocketInitial ||
                              state is WebsocketDisconnected ||
                              state is WebsocketError) {
                            context
                                .read<WebsocketBloc>()
                                .add(ConnectWebsocketEvent());
                          } else if (state is WebsocketConnected ||
                              state is WebsocketDataReceived) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).price_ticker_connected,
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.circle,
                                    size: 18, color: Colors.green),
                              ],
                            );
                          } else if (state is WebsocketConnecting ||
                              state is WebsocketInitial) {
                            return Text(S.of(context).price_ticker_loading);
                          } else if (state is WebsocketDisconnected ||
                              state is WebsocketError) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).price_ticker_disconnected,
                                ),
                                const SizedBox(width: 5),
                                const Icon(Icons.circle,
                                    size: 18, color: Colors.red),
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3,
                        labelColor: ColorManager.secondaryColor,
                        unselectedLabelColor: Colors.black,
                        tabs: [
                          Tab(
                            text: S.of(context).popular,
                          ),
                          Tab(
                            text: S.of(context).watchlist,
                          ),
                        ],
                      ),
                      const Expanded(
                        child: TabBarView(
                          children: [
                            PopularStocksScreen(),
                            WatchListStocksScreen()
                          ],
                        ),
                      )
                    ],
                  ),
                )));
      },
    );
  }
}
