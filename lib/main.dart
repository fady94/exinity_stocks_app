import 'dart:async';

import 'package:exinity_app/app.dart';
import 'package:exinity_app/core/utilities/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'injection_container.dart' as di;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    Intl.defaultLocale = 'en_US';

    await di.init();
    return SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    ).then((_) => runApp(const MyApp()));
  }, (error, stackTrace) {
    if (kDebugMode) {
      log.e('runZonedGuarded: $error');
      log.e('runZonedGuarded: $stackTrace');
    }
  });
}
