import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exinity_app/core/utilities/logger.dart';
import 'package:flutter/material.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String headerMessage = "";
    options.headers.forEach((k, v) => headerMessage += '► $k: $v\n');
    if (options.headers['Content-Type'] == 'application/json') {
      try {
        options.queryParameters.forEach(
          (k, v) => debugPrint(
            '► $k: $v',
          ),
        );
      } catch (_) {}
      try {
        const JsonEncoder encoder = JsonEncoder.withIndent('  ');
        final String prettyJson = encoder.convert(options.data);
      } catch (e, stackTrace) {
        log.e("Failed to extract json request $e , $stackTrace");
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException dioException, ErrorInterceptorHandler handler) {
    log.e(
      "<-- ${dioException.message} ${dioException.response?.requestOptions != null ? (dioException.response!.requestOptions.baseUrl + dioException.response!.requestOptions.path) : 'URL'}\n\n"
      "${dioException.response != null ? dioException.response!.data : 'Unknown Error'}",
    );

    super.onError(dioException, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    String headerMessage = "";
    response.headers.forEach((k, v) => headerMessage += '► $k: $v\n');

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    final String prettyJson = encoder.convert(response.data);

    super.onResponse(response, handler);
  }
}
