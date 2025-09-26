class ResultNoDataException implements Exception {
  final String message;

  const ResultNoDataException() : message = 'No data';

  const ResultNoDataException.withMessage({required this.message});

  @override
  String toString() => message;
}
