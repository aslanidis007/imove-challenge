import '../models/api_response.dart';

extension ApiResponseExtensions<T> on ApiResponse<T> {
  bool get isSuccessStatusCode => statusCode != null && statusCode! >= 200 && statusCode! < 300;
  bool get isUnauthorizedStatusCode => statusCode != null && statusCode == 401;
}
