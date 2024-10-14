// ignore_for_file: unnecessary_cast

import 'package:exinity_app/features/stocks/presentation/bloc/search/search_bloc.dart';
import 'package:exinity_app/features/stocks/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(SearchQueryCleared());
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).search_stocks),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                if (value.length >= 2) {
                  context
                      .read<SearchBloc>()
                      .add(SearchQueryChanged(query: value));
                }
              },
              decoration: InputDecoration(
                hintText: S.of(context).search_hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is SearchFailed) {
                    return Center(
                        child: Text(S.of(context).failed_to_search_stocks));
                  }

                  if (state is SearchLoaded) {
                    return ListView.builder(
                      itemCount: state.symbols.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.trending_up),
                          title: Text(state.symbols[index].symbol),
                          subtitle: Text(state.symbols[index].description),
                          trailing: BlocBuilder<WatchlistBloc, WatchlistState>(
                            builder: (context, watchlistState) {
                              if (watchlistState is WatchlistInitial) {
                                context
                                    .read<WatchlistBloc>()
                                    .add(WatchlistEventLoadSymbols());
                              }
                              if (watchlistState is WatchlistLoaded) {
                                return IconButton(
                                    onPressed: () {
                                      (watchlistState as WatchlistLoaded)
                                              .symbols
                                              .contains(
                                                  state.symbols[index].symbol)
                                          ? context.read<WatchlistBloc>().add(
                                              WatchlistEventRemoveSymbol(
                                                  state.symbols[index].symbol))
                                          : context.read<WatchlistBloc>().add(
                                              WatchlistEventAddSymbol(
                                                  state.symbols[index].symbol));
                                    },
                                    icon: (watchlistState).symbols.contains(
                                            state.symbols[index].symbol)
                                        ? const Icon(
                                            Icons.star_sharp,
                                            color: Colors.orange,
                                          )
                                        : const Icon(Icons.star_outline,
                                            color: Colors.grey));
                              } else {
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
