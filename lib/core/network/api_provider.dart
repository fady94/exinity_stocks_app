import 'package:dio/dio.dart';

abstract class APIProvider {
  Future<Response> post({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    ProgressCallback? progressCallback,
    CancelToken? cancelToken,
    int? timeOutSeconds,
    bool isMultipart = false,
  });

  Future<Response> get({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOutSeconds,
    bool isMultipart = false,
  });

  Future<Response> put({
    String? baseUrl,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    ProgressCallback? progressCallback,
    int? timeOutSeconds,
    bool isMultipart = false,
  });

  void setToken(String token);
}
