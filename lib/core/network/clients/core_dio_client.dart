import 'package:dio/dio.dart';
import 'package:imove_challenge/core/network/http/http_service.dart';

import 'abstract_core_dio_client.dart';

class CoreDioClient extends HttpService implements ICoreDioClient {
  late final Dio _httpClient;
  CoreDioClient({
    required Dio httpClient,
    required int httpConnectTimeoutInSeconds,
    required int httpReceiveTimeoutInSeconds,
  }) : super(
         httpClient: httpClient,
         connectTimeout: Duration(seconds: httpConnectTimeoutInSeconds),
         receiveTimeout: Duration(seconds: httpReceiveTimeoutInSeconds),
       ) {
    _httpClient = httpClient;
    _httpClient.options = dioBaseOptions();
  }
}
