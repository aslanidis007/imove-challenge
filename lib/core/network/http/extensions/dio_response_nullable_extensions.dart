import 'package:dio/dio.dart';

extension DioResponseNullableExtensions<T> on Response<T>? {
  bool get isSuccessStatusCode => this != null && this!.isSuccessStatusCode;
  bool get isUnauthorizedStatusCode =>
      this != null && this!.isUnauthorizedStatusCode;
}
