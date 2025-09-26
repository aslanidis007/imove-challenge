class ValidationApiError implements Exception {
  final int? code;
  final String? message;

  ValidationApiError({required this.code, required this.message});

  factory ValidationApiError.fromJson(Map<String, dynamic> json) {
    final data = json['error'] as Map<String, dynamic>;
    return ValidationApiError(code: data['code'] as int?, message: data['message']?.toString());
  }

  @override
  String toString() {
    return 'ValidationApiError(code: $code, message: $message)';
  }
}
