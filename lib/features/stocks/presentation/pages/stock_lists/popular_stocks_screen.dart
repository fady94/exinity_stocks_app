import 'package:exinity_app/extensions/media_query.dart';
import 'package:exinity_app/features/stocks/domain/entities/stock_entity.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/stocks/stocks_bloc_impl.dart';
import 'package:exinity_app/features/stocks/presentation/widgets/stock_list_builder.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularStocksScreen extends StatefulWidget {
  const PopularStocksScreen({super.key});

  @override
  State<PopularStocksScreen> createState() => _PopularStocksScreenState();
}

class _PopularStocksScreenState extends State<PopularStocksScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<PopularStocksBloc, StocksState>(
      builder: (context, state) {
        if (state is StocksInitial) {
          context.read<PopularStocksBloc>().add(GetStocks());
        }
        if (state is StocksLoaded || state is UpdatingStocks) {
          List<StockEntity> stocks = state is StocksLoaded
              ? state.stocks
              : (state as UpdatingStocks).stocks;
          return StockListBuilder(stocks: stocks, onDismissed: (sym) {});
        } else if (state is StocksFailed) {
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
                    context.read<PopularStocksBloc>().add(GetStocks());
                  },
                  child: Text(S.of(context).retry))
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
