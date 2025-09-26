import 'package:dio/dio.dart';
import 'package:imove_challenge/core/network/extensions/dio_extensions.dart';
import 'package:imove_challenge/core/network/http/http_service.dart';
import 'package:imove_challenge/core/services/refresh_token/user_access_token/abstract_refresh_user_access_token_service.dart';

import 'abstract_user_access_token_http_client.dart';

class UserAccessTokenDioClient extends HttpService implements IUserAccessTokenHttpClient {
  late final Dio _httpClient;
  late final IRefreshUserAccessTokenService _refreshUserAccessTokenService;
  UserAccessTokenDioClient({
    required Dio httpClient,
    required int httpConnectTimeoutInSeconds,
    required int httpReceiveTimeoutInSeconds,
    required IRefreshUserAccessTokenService refreshUserAccessTokenService,
  }) : super(
         httpClient: httpClient,
         connectTimeout: Duration(seconds: httpConnectTimeoutInSeconds),
         receiveTimeout: Duration(seconds: httpReceiveTimeoutInSeconds),
       ) {
    _httpClient = httpClient;
    _refreshUserAccessTokenService = refreshUserAccessTokenService;
    _httpClient
      ..interceptors.add(_refreshUserAccessTokenService.createAuthInterceptor())
      ..configureRetryInterceptor()
      ..options = dioBaseOptions();
  }
}
