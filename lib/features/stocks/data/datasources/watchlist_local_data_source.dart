import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/local/shared_prefernces_helper.dart';

abstract class WatchlistLocalDataSource {
  Either<Failure, List<String>> getWatchlist();

  Either<Failure, bool> addToWatchlist(String symbol);

  Either<Failure, bool> removeFromWatchlist(String symbol);
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final PreferenceHelper preferenceHelper;
  final String watchlistKey = "watchlist";

  WatchlistLocalDataSourceImpl({required this.preferenceHelper});

  @override
  Either<Failure, List<String>> getWatchlist() {
    try {
      final List<String>? watchlist =
          preferenceHelper.getListData(key: watchlistKey);
      return Right(watchlist ?? []);
    } catch (e) {
      return Left(LogicFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> addToWatchlist(String symbol) {
    try {
      List<String> watchlist =
          preferenceHelper.getListData(key: watchlistKey) ?? [];
      watchlist.add(symbol);
      preferenceHelper.saveList(key: watchlistKey, value: watchlist);
      return const Right(true);
    } catch (e) {
      return Left(LogicFailure(message: e.toString()));
    }
  }

  @override
  Either<Failure, bool> removeFromWatchlist(String symbol) {
    try {
      List<String> watchlist =
          preferenceHelper.getListData(key: watchlistKey) ?? [];
      watchlist.remove(symbol);
      preferenceHelper.saveList(key: watchlistKey, value: watchlist);
      return const Right(true);
    } catch (e) {
      return Left(LogicFailure(message: e.toString()));
    }
  }
}
