import 'package:envied/envied.dart';
import 'package:flutter/foundation.dart';

part 'env.g.dart';

@Envied(path: kDebugMode ? '.env.dev' : '.env.prod', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API_URL')
  static final String apiUrl = _Env.apiUrl;

  @EnviedField(varName: 'WEBSOCKET_URL')
  static final String webSocketUrl = _Env.webSocketUrl;

  @EnviedField(varName: 'TOKEN')
  static final String token = _Env.token;
}
