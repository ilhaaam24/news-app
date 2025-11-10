class GeneralException implements Exception {
  final String message;
  const GeneralException(this.message);
}

class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class StatusException implements Exception {
  final String message;
  const StatusException(this.message);
}

class EmptyException implements Exception {
  final String message;
  const EmptyException(this.message);
}
