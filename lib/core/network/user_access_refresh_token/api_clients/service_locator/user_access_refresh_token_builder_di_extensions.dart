import 'package:get_it/get_it.dart';

import '../abstract_user_access_refresh_token_builder.dart';
import '../user_access_refresh_token_builder.dart';

extension UserAccessRefreshTokenBuilderDiExtensions on GetIt {
  GetIt registerUserAccessRefreshTokenBuilder({
    required String baseUrl,
    required String apiBasePath,
  }) {
    registerLazySingleton<IUserAccessRefreshTokenBuilder>(
      () => UserAccessRefreshTokenBuilder(baseUrl: baseUrl, apiBasePath: apiBasePath),
    );
    return this;
  }

  IUserAccessRefreshTokenBuilder get userAccessRefreshTokenBuilder =>
      get<IUserAccessRefreshTokenBuilder>();
}
