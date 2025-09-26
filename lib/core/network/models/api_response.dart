import 'dart:convert';

import 'package:imove_challenge/core/network/models/api_redirect_record.dart';
import 'api_headers.dart';

class ApiResponse<T> {
  ApiResponse({
    this.data,
    this.statusCode,
    this.statusMessage,
    this.isRedirect = false,
    this.redirects = const [],
    Map<String, dynamic>? extra,
    ApiHeaders? headers,
  }) : headers = headers ?? ApiHeaders(),
       extra = extra ?? <String, dynamic>{};

  /// Generic response payload
  T? data;

  /// HTTP status code
  int? statusCode;

  /// Reason phrase
  String? statusMessage;

  /// Response headers
  ApiHeaders headers;

  /// True if response was redirected
  bool isRedirect;

  /// Redirection history
  List<ApiRedirectRecord> redirects;

  /// Custom extra data
  Map<String, dynamic> extra;

  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
