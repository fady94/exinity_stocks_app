class ServerException implements Exception {}

class EmptyCacheException implements Exception {}

class OfflineException implements Exception {}

class UnauthorizedException implements Exception {}

class BadRequestException implements Exception {
  final String message;
  BadRequestException({this.message = 'Bad Request'});
}
