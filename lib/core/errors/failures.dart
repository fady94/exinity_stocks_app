import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure({required this.message});
}

class OfflineFailure extends Failure {
  const OfflineFailure({super.message = 'Network Connection Failed'});

  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server Failure'});
  @override
  List<Object?> get props => [];
}

class BadRequestFailure extends Failure {
  final String message;
  const BadRequestFailure({this.message = 'Bad Request'})
      : super(message: message);
  @override
  List<Object?> get props => [message];
}

class EmptyFieldFailure extends Failure {
  final String message;
  const EmptyFieldFailure({this.message = 'Empty Field'})
      : super(message: message);
  @override
  List<Object?> get props => [message];
}

class EmptyDataFailure extends Failure {
  const EmptyDataFailure({String message = 'No Data Found'})
      : super(message: message);
  @override
  List<Object?> get props => [];
}

class SymbolNotFound extends Failure {
  final String symbol;
  const SymbolNotFound(
      {required this.symbol, String message = 'Symbol Not Found'})
      : super(message: message);
  @override
  List<Object?> get props => [];
}

class LogicFailure extends Failure {
  final String message;
  const LogicFailure({this.message = 'Logic Failure'})
      : super(message: message);
  @override
  List<Object?> get props => [message];
}
