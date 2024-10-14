import 'package:exinity_app/core/errors/failures.dart';
import 'package:exinity_app/generated/l10n.dart';
import 'package:flutter/material.dart';

String mapFailureToMessage(BuildContext context, Failure failure) {
  switch (failure.runtimeType) {
    case const (ServerFailure):
      return S.of(context).server_failure;
    case const (OfflineFailure):
      return S.of(context).no_internet_connection;
    case const (BadRequestFailure):
      return (failure as BadRequestFailure).message;
    case const (EmptyFieldFailure):
      return (failure as EmptyFieldFailure).message;
    default:
      return "Unexpected error";
  }
}
