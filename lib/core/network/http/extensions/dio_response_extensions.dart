import 'package:dio/dio.dart';

extension DioResponseExtensions<T> on Response<T> {
  bool get isSuccessStatusCode => statusCode != null && statusCode! >= 200 && statusCode! < 300;
  bool get isUnauthorizedStatusCode => statusCode != null && statusCode == 401;
}
