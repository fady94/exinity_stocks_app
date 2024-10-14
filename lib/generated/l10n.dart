// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Exinity Stocks App`
  String get title {
    return Intl.message(
      'Exinity Stocks App',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Price Ticker Connected`
  String get price_ticker_connected {
    return Intl.message(
      'Price Ticker Connected',
      name: 'price_ticker_connected',
      desc: '',
      args: [],
    );
  }

  /// `Price Ticker Disconnected`
  String get price_ticker_disconnected {
    return Intl.message(
      'Price Ticker Disconnected',
      name: 'price_ticker_disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Price Ticker Error`
  String get price_ticker_error {
    return Intl.message(
      'Price Ticker Error',
      name: 'price_ticker_error',
      desc: '',
      args: [],
    );
  }

  /// `Connecting To Price Ticker...`
  String get price_ticker_loading {
    return Intl.message(
      'Connecting To Price Ticker...',
      name: 'price_ticker_loading',
      desc: '',
      args: [],
    );
  }

  /// `Reconnecting To Price Ticker...`
  String get price_ticker_reconnecting {
    return Intl.message(
      'Reconnecting To Price Ticker...',
      name: 'price_ticker_reconnecting',
      desc: '',
      args: [],
    );
  }

  /// `Popular Stocks ‎️‍🔥`
  String get popular {
    return Intl.message(
      'Popular Stocks ‎️‍🔥',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Watchlist`
  String get watchlist {
    return Intl.message(
      'Watchlist',
      name: 'watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Search Stocks`
  String get search_stocks {
    return Intl.message(
      'Search Stocks',
      name: 'search_stocks',
      desc: '',
      args: [],
    );
  }

  /// `Failed To Search Stocks`
  String get failed_to_search_stocks {
    return Intl.message(
      'Failed To Search Stocks',
      name: 'failed_to_search_stocks',
      desc: '',
      args: [],
    );
  }

  /// `ex: Google, Apple, Tesla`
  String get search_hint {
    return Intl.message(
      'ex: Google, Apple, Tesla',
      name: 'search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Loading Stocks`
  String get loading_stocks {
    return Intl.message(
      'Loading Stocks',
      name: 'loading_stocks',
      desc: '',
      args: [],
    );
  }

  /// `No Stocks Found`
  String get no_stocks_found {
    return Intl.message(
      'No Stocks Found',
      name: 'no_stocks_found',
      desc: '',
      args: [],
    );
  }

  /// `Stocks`
  String get stocks {
    return Intl.message(
      'Stocks',
      name: 'stocks',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get no_internet_connection {
    return Intl.message(
      'No Internet Connection',
      name: 'no_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Your watchlist is empty.\n Start Searching for favorite stocks then add to watchlist`
  String get watchlist_empty {
    return Intl.message(
      'Your watchlist is empty.\n Start Searching for favorite stocks then add to watchlist',
      name: 'watchlist_empty',
      desc: '',
      args: [],
    );
  }

  /// `Server Failure`
  String get server_failure {
    return Intl.message(
      'Server Failure',
      name: 'server_failure',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
