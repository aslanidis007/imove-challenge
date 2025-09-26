import 'package:dio/dio.dart';
import 'package:imove_challenge/core/network/http/extensions/dio_response_extensions.dart';
import 'package:result_dart/result_dart.dart';

import '../../services/debug/log_service.dart';
import '../models/api_headers.dart';
import '../models/api_response.dart';
import '../errors/models/validation_api_error.dart';
import '../errors/response_handler.dart';
import 'abstract_http_service.dart';
import 'exceptions/http_service_exceptions.dart';

class HttpService implements IHttpService {
  final Dio _httpClient;
  final Duration _connectTimeout;
  final Duration _receiveTimeout;

  HttpService({
    required Dio httpClient,
    required Duration connectTimeout,
    required Duration receiveTimeout,
  }) : _httpClient = httpClient,
       _connectTimeout = connectTimeout,
       _receiveTimeout = receiveTimeout;

  Map<String, String> defaultJsonHeaders() => {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  bool Function(int?) validateStatus = (status) =>
      (status != null && status >= 200 && status < 300) ||
      status == 400 ||
      status == 422 ||
      status == 404;

  BaseOptions dioBaseOptions() => BaseOptions(
    headers: defaultJsonHeaders(),
    connectTimeout: _connectTimeout,
    receiveTimeout: _receiveTimeout,
  );

  @override
  AsyncResult<ApiResponse<dynamic>> get({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? extra,
    ResponseType? responseType,
  }) async {
    try {
      final response = await _httpClient.get(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {..._httpClient.options.headers, ...headers ?? {}},
          validateStatus: validateStatus,
          extra: extra,
          responseType: responseType,
        ),
      );

      if (response.isSuccessStatusCode) {
        return Success(
          ApiResponse(
            data: response.data,
            statusCode: response.statusCode,
            statusMessage: response.statusMessage,
            headers: ApiHeaders(headers: response.headers.map),
          ),
        );
      }
      kLog.e(ResponseHandler().formatDioErrorResponse(response), stackTrace: StackTrace.current);
      if (response.data is Map<String, dynamic> && response.isSuccessStatusCode) {
        return Failure(ValidationApiError.fromJson(response.data as Map<String, dynamic>));
      }
      return Failure(
        HttpServiceException(message: ResponseHandler().formatDioErrorResponse(response)),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        kLog.e(
          ResponseHandler().formatDioErrorResponse(e.response!),
          stackTrace: StackTrace.current,
        );
      }
      final exception = e as Exception;
      return Failure(exception);
    }
  }

  @override
  AsyncResult<ApiResponse<dynamic>> post({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic> data = const {},
    Map<String, dynamic>? extra,
  }) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
        url,
        data: data,
        queryParameters: queryParams,
        options: Options(
          headers: {..._httpClient.options.headers, ...headers ?? {}},
          validateStatus: validateStatus,
          extra: extra,
        ),
      );

      if (response.isSuccessStatusCode && response.data['data'] != null) {
        return Success(
          ApiResponse(
            data: response.data,
            statusCode: response.statusCode,
            statusMessage: response.statusMessage,
            headers: ApiHeaders(headers: response.headers.map),
          ),
        );
      }
      if (response.data is Map<String, dynamic> && response.isSuccessStatusCode) {
        return Failure(ValidationApiError.fromJson(response.data as Map<String, dynamic>));
      }
      return Failure(
        HttpServiceException(message: ResponseHandler().formatDioErrorResponse(response)),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        kLog.e(
          ResponseHandler().formatDioErrorResponse(e.response!),
          stackTrace: StackTrace.current,
        );
      }
      final exception = e as Exception;
      return Failure(exception);
    }
  }

  @override
  AsyncResult<ApiResponse<dynamic>> put({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic> data = const {},
    Map<String, dynamic>? extra,
  }) async {
    try {
      final response = await _httpClient.put(
        url,
        data: data,
        queryParameters: queryParams,
        options: Options(
          headers: {..._httpClient.options.headers, ...headers ?? {}},
          validateStatus: validateStatus,
          extra: extra,
        ),
      );
      if (response.isSuccessStatusCode) {
        return Success(
          ApiResponse(
            data: response.data,
            statusCode: response.statusCode,
            statusMessage: response.statusMessage,
            headers: ApiHeaders(headers: response.headers.map),
          ),
        );
      }
      kLog.e(ResponseHandler().formatDioErrorResponse(response), stackTrace: StackTrace.current);
      if (response.data is Map<String, dynamic> && response.isSuccessStatusCode) {
        return Failure(ValidationApiError.fromJson(response.data as Map<String, dynamic>));
      }
      return Failure(
        HttpServiceException(message: ResponseHandler().formatDioErrorResponse(response)),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        kLog.e(
          ResponseHandler().formatDioErrorResponse(e.response!),
          stackTrace: StackTrace.current,
        );
      }
      final exception = e as Exception;
      return Failure(exception);
    }
  }

  @override
  AsyncResult<ApiResponse<dynamic>> delete({
    required String url,
    Map<String, String>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final response = await _httpClient.delete(
        url,
        queryParameters: queryParams,
        options: Options(
          headers: {..._httpClient.options.headers, ...headers ?? {}},
          validateStatus: validateStatus,
          extra: extra,
        ),
      );
      if (response.isSuccessStatusCode) {
        return Success(
          ApiResponse(
            data: response.data,
            statusCode: response.statusCode,
            statusMessage: response.statusMessage,
            headers: ApiHeaders(headers: response.headers.map),
          ),
        );
      }
      kLog.e(ResponseHandler().formatDioErrorResponse(response), stackTrace: StackTrace.current);
      if (response.data is Map<String, dynamic> && response.isSuccessStatusCode) {
        return Failure(ValidationApiError.fromJson(response.data as Map<String, dynamic>));
      }
      return Failure(
        HttpServiceException(message: ResponseHandler().formatDioErrorResponse(response)),
      );
    } on DioException catch (e) {
      if (e.response != null) {
        kLog.e(
          ResponseHandler().formatDioErrorResponse(e.response!),
          stackTrace: StackTrace.current,
        );
      }
      final exception = e as Exception;
      return Failure(exception);
    }
  }
}
