import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/api/dio_client.dart';
import 'package:exinity_app/core/env/env.dart';
import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/shared/data/models/symbol_model.dart';

abstract class SymbolsRemoteDataSource {
  Future<Either<Failure, List<SymbolModel>>> getAllSymbols();

  Future<Either<Failure, List<SymbolModel>>> search(String query);
}

class SymbolsRemoteDataSourceImpl implements SymbolsRemoteDataSource {
  final DioClient dioClient;

  SymbolsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Either<Failure, List<SymbolModel>>> getAllSymbols() async {
    try {
      final response = await dioClient.getRequest(
        "stock/symbol",
        queryParameters: {"token": Env.token, "exchange": "US"},
        isIsolate: true,
      );

      return response.fold((failure) => Left(failure), (symbolsData) {
        if (symbolsData is List) {
          return Right(
              symbolsData.map((e) => SymbolModel.fromJson(e)).toList());
        }
        return const Left(ServerFailure());
      });
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<SymbolModel>>> search(String query) async {
    final response = await dioClient.getRequest(
      "search",
      queryParameters: {"q": query, "token": Env.token, "exchange": "US"},
      isIsolate: true,
      converter: (data) =>
          (data['result'] as List).map((e) => SymbolModel.fromJson(e)).toList(),
    );
    return response.fold(
      (failure) => Left(failure),
      (data) {
        return Right(data);
      },
    );
  }
}
