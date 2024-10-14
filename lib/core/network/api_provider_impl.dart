import 'package:dio/dio.dart';
import 'package:exinity_app/core/env/env.dart';
import 'package:exinity_app/core/network/api_provider.dart';

class APIProviderImpl implements APIProvider {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: Env.apiUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
    ),
  );

  @override
  Future<Response> get(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      CancelToken? cancelToken,
      int? timeOutSeconds,
      bool isMultipart = false}) async {
    if (timeOutSeconds != null) {
      dio.options.connectTimeout = Duration(seconds: timeOutSeconds);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'en',
    };
    return await dio.get(
      endPoint,
      queryParameters: query,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> post(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      ProgressCallback? progressCallback,
      CancelToken? cancelToken,
      int? timeOutSeconds,
      bool isMultipart = false}) async {
    if (timeOutSeconds != null) {
      dio.options.connectTimeout = Duration(seconds: timeOutSeconds);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'en',
    };

    return await dio.post(
      endPoint,
      data: data,
      queryParameters: query,
      onSendProgress: progressCallback,
      cancelToken: cancelToken,
    );
  }

  @override
  Future<Response> put(
      {String? baseUrl,
      required String endPoint,
      data,
      query,
      String? token,
      ProgressCallback? progressCallback,
      CancelToken? cancelToken,
      int? timeOutSeconds,
      bool isMultipart = false}) async {
    if (timeOutSeconds != null) {
      dio.options.connectTimeout = Duration(seconds: timeOutSeconds);
    }

    dio.options.headers = {
      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
      'lang': 'en',
    };
    return await dio.put(
      endPoint,
      data: data,
      queryParameters: query,
      onSendProgress: progressCallback,
      cancelToken: cancelToken,
    );
  }

  @override
  void setToken(String token) {
    dio.options.headers = {'Authorization': 'Bearer $token'};
  }
}
