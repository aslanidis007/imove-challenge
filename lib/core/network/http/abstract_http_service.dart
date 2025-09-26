import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../models/api_response.dart';

abstract class IHttpService {
  AsyncResult<ApiResponse<dynamic>> get({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? extra,
    ResponseType? responseType,
  });
  AsyncResult<ApiResponse<dynamic>> post({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic> data = const {},
    Map<String, dynamic>? extra,
  });
  AsyncResult<ApiResponse<dynamic>> put({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic> data = const {},
    Map<String, dynamic>? extra,
  });

  AsyncResult<ApiResponse<dynamic>> delete({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? extra,
  });
}
