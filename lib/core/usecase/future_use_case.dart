import 'package:dartz/dartz.dart';
import 'package:exinity_app/core/errors/failures.dart';

abstract class FutureUseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
