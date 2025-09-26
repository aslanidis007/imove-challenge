import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/token_storage/service_locator/user_token_storage_di_extensions.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/service_locator/refresh_token_repository_di_extensions.dart';

import 'package:dio/dio.dart';
import 'package:imove_challenge/core/services/refresh_token/user_access_token/abstract_refresh_user_access_token_service.dart';
import 'package:imove_challenge/core/services/refresh_token/user_access_token/refresh_user_access_token_service.dart';

extension RefreshUserAccessTokenDiExtensions on GetIt {
  GetIt registerRefreshUserAccessTokenService() {
    registerLazySingleton<IRefreshUserAccessTokenService>(
      () => RefreshUserAccessTokenService(
        tokenStorage: userAccessTokenStorage,
        refreshTokenRepository: refreshTokenRepository,
        dio: get<Dio>(),
      ),
    );
    return this;
  }

  IRefreshUserAccessTokenService get refreshUserAccessTokenService =>
      get<IRefreshUserAccessTokenService>();
}
