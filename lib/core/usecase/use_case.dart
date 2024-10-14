import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exinity_app/core/errors/failures.dart';

abstract class UseCase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
