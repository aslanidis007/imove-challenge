import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/services/refresh_token/user_access_token/service_locator/refresh_user_access_token_service_di_extensions.dart';

import '../abstract_user_access_token_http_client.dart';
import '../user_access_token_dio_client.dart';

extension UserAccessTokenDioClientDiExtensions on GetIt {
  GetIt registerUserAccessTokenDioClient({
    required int httpConnectTimeoutInSeconds,
    required int httpReceiveTimeoutInSeconds,
  }) {
    registerLazySingleton<IUserAccessTokenHttpClient>(
      () => UserAccessTokenDioClient(
        httpClient: get<Dio>(),
        httpConnectTimeoutInSeconds: httpConnectTimeoutInSeconds,
        httpReceiveTimeoutInSeconds: httpReceiveTimeoutInSeconds,
        refreshUserAccessTokenService: refreshUserAccessTokenService,
      ),
    );
    return this;
  }

  IUserAccessTokenHttpClient get userAccessTokenDioClient =>
      get<IUserAccessTokenHttpClient>();
}
