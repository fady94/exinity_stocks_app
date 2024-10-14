// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "failed_to_search_stocks":
            MessageLookupByLibrary.simpleMessage("Failed To Search Stocks"),
        "loading_stocks":
            MessageLookupByLibrary.simpleMessage("Loading Stocks"),
        "no_internet_connection":
            MessageLookupByLibrary.simpleMessage("No Internet Connection"),
        "no_stocks_found":
            MessageLookupByLibrary.simpleMessage("No Stocks Found"),
        "popular": MessageLookupByLibrary.simpleMessage("Popular Stocks ‎️‍🔥"),
        "price_ticker_connected":
            MessageLookupByLibrary.simpleMessage("Price Ticker Connected"),
        "price_ticker_disconnected":
            MessageLookupByLibrary.simpleMessage("Price Ticker Disconnected"),
        "price_ticker_error":
            MessageLookupByLibrary.simpleMessage("Price Ticker Error"),
        "price_ticker_loading": MessageLookupByLibrary.simpleMessage(
            "Connecting To Price Ticker..."),
        "price_ticker_reconnecting": MessageLookupByLibrary.simpleMessage(
            "Reconnecting To Price Ticker..."),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "search_hint":
            MessageLookupByLibrary.simpleMessage("ex: Google, Apple, Tesla"),
        "search_stocks": MessageLookupByLibrary.simpleMessage("Search Stocks"),
        "server_failure":
            MessageLookupByLibrary.simpleMessage("Server Failure"),
        "stocks": MessageLookupByLibrary.simpleMessage("Stocks"),
        "title": MessageLookupByLibrary.simpleMessage("Exinity Stocks App"),
        "watchlist": MessageLookupByLibrary.simpleMessage("Watchlist"),
        "watchlist_empty": MessageLookupByLibrary.simpleMessage(
            "Your watchlist is empty.\n Start Searching for favorite stocks then add to watchlist")
      };
}
