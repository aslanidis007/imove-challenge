class RefreshTokenException implements Exception {
  final String message;

  RefreshTokenException(this.message);

  @override
  String toString() {
    return 'RefreshTokenException: $message';
  }
}
