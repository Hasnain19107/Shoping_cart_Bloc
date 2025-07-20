class ServerException implements Exception {
  final String message;

  ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message}); // Fixed: removed duplicate parameter
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});
}
