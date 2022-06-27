// Common Errors
class NetworkException implements Exception {}

class UnknownException implements Exception {}

class ValidationException implements Exception {
  final String description;

  ValidationException(this.description);
}

class ResponseException implements Exception {
  final String message;

  ResponseException(this.message);
}
