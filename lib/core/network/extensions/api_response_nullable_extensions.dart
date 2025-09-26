import '../models/api_response.dart';
import 'api_response_extensions.dart';

extension ApiResponseNullableExtensions<T> on ApiResponse<T>? {
  bool get isSuccessStatusCode => this != null && this!.isSuccessStatusCode;
  bool get isUnauthorizedStatusCode => this != null && this!.isUnauthorizedStatusCode;
}
