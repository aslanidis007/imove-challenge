class ApiRedirectRecord {
  const ApiRedirectRecord(this.statusCode, this.method, this.location);

  /// Returns the status code used for the redirect.
  final int statusCode;

  /// Returns the method used for the redirect.
  final String method;

  /// Returns the location for the redirect.
  final Uri location;

  @override
  String toString() {
    return 'ApiRedirectRecord'
        '{statusCode: $statusCode, method: $method, location: $location}';
  }
}
