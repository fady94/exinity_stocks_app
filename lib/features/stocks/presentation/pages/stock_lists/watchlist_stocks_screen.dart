import 'package:exinity_app/extensions/media_query.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/widgets/stock_list_builder.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchListStocksScreen extends StatefulWidget {
  const WatchListStocksScreen({super.key});

  @override
  State<WatchListStocksScreen> createState() => _WatchListStocksScreenState();
}

class _WatchListStocksScreenState extends State<WatchListStocksScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<WatchlistBloc, WatchlistState>(
      listener: (
        context,
        state,
      ) {
        if (state is WatchlistLoaded) {
          context.read<WatchlistStocksBloc>().add(GetStocks());
        }
      },
      builder: (context, state) {
        if (state is WatchlistInitial) {
          context.read<WatchlistBloc>().add(WatchlistEventLoadSymbols());
        }

        if (state is WatchlistLoaded) {
          if (state.symbols.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    size: context.height / 3,
                  ),
                  Text(
                    textAlign: TextAlign.center,
                    S.of(context).watchlist_empty,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            );
          }
          return BlocBuilder<WatchlistStocksBloc, StocksState>(
            builder: (context, state) {
              if (state is StocksLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is StocksFailed) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: context.height / 5,
                    ),
                    Text(
                      "${state.failure?.message}",
                      style: const TextStyle(fontSize: 20),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          context.read<WatchlistStocksBloc>().add(GetStocks());
                        },
                        child: Text(S.of(context).retry))
                  ],
                );
              }

              if (state is StocksLoaded || state is UpdatingStocks) {
                List<StockEntity> stocks = state is StocksLoaded
                    ? state.stocks
                    : (state as UpdatingStocks).stocks;

                return stocks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star_border,
                              size: context.height / 3,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              S.of(context).watchlist_empty,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    : StockListBuilder(
                        stocks: stocks,
                        isDismissable: true,
                        onDismissed: (sym) {
                          context
                              .read<WatchlistBloc>()
                              .add(WatchlistEventRemoveSymbol(sym));
                        });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
