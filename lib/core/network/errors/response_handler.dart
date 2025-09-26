import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import 'models/validation_api_error.dart';

class ResponseHandler {
  Failure<T, Exception> failureFromResponse<T extends Object>(Response<dynamic> response) {
    try {
      final dynamic responseData = response.data;

      if (responseData == null) {
        return Failure(Exception("Empty response from server"));
      }

      if (responseData is List) {
        final List<dynamic> dataValidationResponse = responseData;
        final validationResponse = dataValidationResponse
            .map((p) => ValidationApiError.fromJson(p as Map<String, dynamic>))
            .toList();
        return Failure(
          Exception(
            validationResponse.isNotEmpty ? validationResponse[0].message : "Unknown Error",
          ),
        );
      }

      if (responseData is Map<String, dynamic>) {
        final validationResponse = ValidationApiError.fromJson(responseData);
        return Failure(Exception(validationResponse.message));
      }

      if (responseData is String) {
        return Failure(Exception("Server responded with a string: $responseData"));
      }
      return Failure(Exception("Unknown error format from server: $responseData"));
    } catch (e, stacktrace) {
      return Failure(Exception("Error processing error response: $e $stacktrace"));
    }
  }

  String formatDioErrorResponse(Response<dynamic> response, {String? reason}) {
    final buffer = StringBuffer();
    final headers = response.requestOptions.headers;

    final authHeader = headers[HttpHeaders.authorizationHeader];
    final approovHeader = headers['Approov-Token'];

    final String? shortAuth = authHeader is String && authHeader.startsWith('Bearer ')
        ? authHeader.split(' ').last
        : null;
    final requestBodyString = response.requestOptions.data != null
        ? jsonEncode(response.requestOptions.data)
        : 'null';
    final requestHeaders = response.requestOptions.headers;

    buffer.writeln('❌ Dio Error ${reason != null ? "→ $reason" : ""}');
    buffer.writeln('→ Status Code: ${response.statusCode}');
    buffer.writeln('→ Platform: ${Platform.operatingSystem}');
    buffer.writeln('→ OS Version: ${Platform.operatingSystemVersion}');
    buffer.writeln('→ Dart Version: ${Platform.version}');
    buffer.writeln('→ Body request: ${response.requestOptions.data}');
    buffer.writeln('→ Status Message: ${response.statusMessage}');
    buffer.writeln('→ URI: ${response.requestOptions.uri}');
    buffer.writeln('→ Method: ${response.requestOptions.method}');
    buffer.writeln('→ Request Body: $requestBodyString');
    buffer.writeln('→ Request Headers: $requestHeaders');
    buffer.writeln('→ Authorization: ${shortAuth != null ? "Bearer $shortAuth" : "null"}');
    buffer.writeln('→ Approov-Token: ${approovHeader != null ? "$approovHeader" : "null"}');
    buffer.writeln('→ Headers: $headers');
    buffer.writeln('→ Query Params: ${response.requestOptions.queryParameters}');
    buffer.writeln('→ Data: ${response.data}');
    buffer.writeln('→ onSendProgress: ${response.requestOptions.onSendProgress != null}');
    buffer.writeln('→ onReceiveProgress: ${response.requestOptions.onReceiveProgress != null}');
    buffer.writeln('→ Extra: ${response.requestOptions.extra}');
    buffer.writeln('→ Response Type: ${response.requestOptions.responseType}');
    buffer.writeln('→ Content-Type: ${response.requestOptions.contentType}');
    buffer.writeln('→ Redirects: ${response.isRedirect}');

    return buffer.toString();
  }
}
