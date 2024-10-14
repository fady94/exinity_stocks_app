// Mocks generated by Mockito 5.4.4 from annotations
// in exinity_app/test/features/stocks/data/repositories/stock_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:exinity_app/core/errors/failures.dart' as _i5;
import 'package:exinity_app/core/network/network_info.dart' as _i11;
import 'package:exinity_app/core/services/websocket/web_socket_service.dart'
    as _i12;
import 'package:exinity_app/features/stocks/data/datasources/stock_api_remote_data_source.dart'
    as _i3;
import 'package:exinity_app/features/stocks/data/datasources/stock_websocket_remote_data_sourc.dart'
    as _i9;
import 'package:exinity_app/features/stocks/data/datasources/symbols_remote_data_source.dart'
    as _i7;
import 'package:exinity_app/features/stocks/data/datasources/watchlist_local_data_source.dart'
    as _i13;
import 'package:exinity_app/features/stocks/data/models/stock_api_model.dart'
    as _i6;
import 'package:exinity_app/features/stocks/data/models/stock_websocket_model.dart'
    as _i10;
import 'package:exinity_app/shared/data/models/symbol_model.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDuration_1 extends _i1.SmartFake implements Duration {
  _FakeDuration_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StockApiRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStockApiRemoteDataSource extends _i1.Mock
    implements _i3.StockApiRemoteDataSource {
  MockStockApiRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.StockApiModel>> getStockInfo(
          String? symbol) =>
      (super.noSuchMethod(
        Invocation.method(
          #getStockInfo,
          [symbol],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, _i6.StockApiModel>>.value(
                _FakeEither_0<_i5.Failure, _i6.StockApiModel>(
          this,
          Invocation.method(
            #getStockInfo,
            [symbol],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.StockApiModel>>);
}

/// A class which mocks [SymbolsRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockSymbolsRemoteDataSource extends _i1.Mock
    implements _i7.SymbolsRemoteDataSource {
  MockSymbolsRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.SymbolModel>>> getAllSymbols() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllSymbols,
          [],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i8.SymbolModel>>>.value(
                _FakeEither_0<_i5.Failure, List<_i8.SymbolModel>>(
          this,
          Invocation.method(
            #getAllSymbols,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.SymbolModel>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i8.SymbolModel>>> search(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #search,
          [query],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i8.SymbolModel>>>.value(
                _FakeEither_0<_i5.Failure, List<_i8.SymbolModel>>(
          this,
          Invocation.method(
            #search,
            [query],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i8.SymbolModel>>>);
}

/// A class which mocks [StockWebsocketRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStockWebsocketRemoteDataSource extends _i1.Mock
    implements _i9.StockWebsocketRemoteDataSource {
  MockStockWebsocketRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i5.Failure, _i10.StockWebsocketModel> getPriceUpdate(
          dynamic json) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPriceUpdate,
          [json],
        ),
        returnValue: _FakeEither_0<_i5.Failure, _i10.StockWebsocketModel>(
          this,
          Invocation.method(
            #getPriceUpdate,
            [json],
          ),
        ),
      ) as _i2.Either<_i5.Failure, _i10.StockWebsocketModel>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i11.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);

  @override
  _i4.Stream<bool> get connectionStatus => (super.noSuchMethod(
        Invocation.getter(#connectionStatus),
        returnValue: _i4.Stream<bool>.empty(),
      ) as _i4.Stream<bool>);
}

/// A class which mocks [WebSocketService].
///
/// See the documentation for Mockito's code generation for more information.
class MockWebSocketService extends _i1.Mock implements _i12.WebSocketService {
  MockWebSocketService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<String> get subscribedSymbols => (super.noSuchMethod(
        Invocation.getter(#subscribedSymbols),
        returnValue: <String>[],
      ) as List<String>);

  @override
  set subscribedSymbols(List<String>? _subscribedSymbols) => super.noSuchMethod(
        Invocation.setter(
          #subscribedSymbols,
          _subscribedSymbols,
        ),
        returnValueForMissingStub: null,
      );

  @override
  int get maxRetries => (super.noSuchMethod(
        Invocation.getter(#maxRetries),
        returnValue: 0,
      ) as int);

  @override
  Duration get retryDelay => (super.noSuchMethod(
        Invocation.getter(#retryDelay),
        returnValue: _FakeDuration_1(
          this,
          Invocation.getter(#retryDelay),
        ),
      ) as Duration);

  @override
  _i4.Stream<dynamic> get messages => (super.noSuchMethod(
        Invocation.getter(#messages),
        returnValue: _i4.Stream<dynamic>.empty(),
      ) as _i4.Stream<dynamic>);

  @override
  _i4.Stream<void> get onDisconnect => (super.noSuchMethod(
        Invocation.getter(#onDisconnect),
        returnValue: _i4.Stream<void>.empty(),
      ) as _i4.Stream<void>);

  @override
  _i4.Future<void> connect() => (super.noSuchMethod(
        Invocation.method(
          #connect,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void send(String? message) => super.noSuchMethod(
        Invocation.method(
          #send,
          [message],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  void subscribeToSymbol(String? symbol) => super.noSuchMethod(
        Invocation.method(
          #subscribeToSymbol,
          [symbol],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void unsubscribeFromSymbol(String? symbol) => super.noSuchMethod(
        Invocation.method(
          #unsubscribeFromSymbol,
          [symbol],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [WatchlistLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistLocalDataSource extends _i1.Mock
    implements _i13.WatchlistLocalDataSource {
  MockWatchlistLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Either<_i5.Failure, List<String>> getWatchlist() => (super.noSuchMethod(
        Invocation.method(
          #getWatchlist,
          [],
        ),
        returnValue: _FakeEither_0<_i5.Failure, List<String>>(
          this,
          Invocation.method(
            #getWatchlist,
            [],
          ),
        ),
      ) as _i2.Either<_i5.Failure, List<String>>);

  @override
  _i2.Either<_i5.Failure, bool> addToWatchlist(String? symbol) =>
      (super.noSuchMethod(
        Invocation.method(
          #addToWatchlist,
          [symbol],
        ),
        returnValue: _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #addToWatchlist,
            [symbol],
          ),
        ),
      ) as _i2.Either<_i5.Failure, bool>);

  @override
  _i2.Either<_i5.Failure, bool> removeFromWatchlist(String? symbol) =>
      (super.noSuchMethod(
        Invocation.method(
          #removeFromWatchlist,
          [symbol],
        ),
        returnValue: _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #removeFromWatchlist,
            [symbol],
          ),
        ),
      ) as _i2.Either<_i5.Failure, bool>);
}
