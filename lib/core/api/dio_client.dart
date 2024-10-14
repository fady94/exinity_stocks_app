import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exinity_app/core/api/dio_interceptor.dart';
import 'package:exinity_app/core/api/isolate_parser.dart';
import 'package:exinity_app/core/env/env.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/core/errors/get-error-message.dart';
import 'package:exinity_app/core/utilities/logger.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  String baseUrl = Env.apiUrl;

  String? _auth;
  bool _isUnitTest = false;
  late Dio _dio;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    _dio = _createDio();

    if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    if (_isUnitTest) {
      /// Return static dio if is unit test
      return _dio;
    } else {
      /// We need to recreate dio to avoid token issue after login

      final dio = _createDio();

      if (!_isUnitTest) dio.interceptors.add(DioInterceptor());

      return dio;
    }
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          receiveTimeout: const Duration(minutes: 1),
          connectTimeout: const Duration(minutes: 1),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    ResponseConverter<T>? converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (converter == null) {
        return Right(response.data);
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }

      final isolateParse = IsolateParser<T>(
        response.data,
        converter,
      );

      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e, stackTrace) {
      log.e("Error: $e , stackTrace: $stackTrace");
      if (e.response?.statusCode == 400) {
        String error = GetErrorMessage.json(e.response?.data);
        return Left(BadRequestFailure(message: error));
      } else {
        return const Left(ServerFailure());
      }
    } catch (e, stackTrace) {
      log.e("Error: $e, stackTrace: $stackTrace");
      return const Left(ServerFailure());
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    ResponseConverter<T>? converter,
    bool isIsolate = true,
  }) async {
    try {
      final response = await dio.post(url, data: data);
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (converter == null) {
        return Right(response.data);
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 400) {
        String error = GetErrorMessage.json(e.response?.data);
        return Left(BadRequestFailure(message: error));
      } else {
        return Left(ServerFailure());
      }
    } catch (e, stackTrace) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, T>> postFile<T>(
    String url, {
    FormData? data,
    ResponseConverter<T>? converter,
    bool isIsolate = true,
  }) async {
    try {
      final dioFile = dio;
      dioFile.options.headers['Content-Type'] = 'multipart/form-data';
      final response = await dioFile.post(url, data: data);
      if ((response.statusCode ?? 0) < 200 ||
          (response.statusCode ?? 0) > 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }

      if (converter == null) {
        return Right(response.data);
      }

      if (!isIsolate) {
        return Right(converter(response.data));
      }
      final isolateParse = IsolateParser<T>(
        response.data as Map<String, dynamic>,
        converter,
      );
      final result = await isolateParse.parseInBackground();
      return Right(result);
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 400) {
        String error = GetErrorMessage.json(e.response?.data);
        return Left(BadRequestFailure(message: error));
      } else {
        return Left(ServerFailure());
      }
    } catch (e, stackTrace) {
      return const Left(ServerFailure());
    }
  }
}
