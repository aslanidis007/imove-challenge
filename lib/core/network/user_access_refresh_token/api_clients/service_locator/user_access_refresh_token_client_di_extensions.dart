import 'package:get_it/get_it.dart';

import '../../../clients/abstract_core_dio_client.dart';
import '../abstract_user_access_refresh_token_builder.dart';
import '../abstract_user_access_refresh_token_client.dart';
import '../user_access_refresh_token_client.dart';

extension UserAccessRefreshTokenClientDiExtensions on GetIt {
  GetIt registerUserAccessRefreshTokenClient() {
    registerLazySingleton<IUserAccessRefreshTokenClient>(
      () => UserAccessRefreshTokenClient(
        coreDioClient: get<ICoreDioClient>(),
        userAccessRefreshTokenBuilder: get<IUserAccessRefreshTokenBuilder>(),
      ),
    );
    return this;
  }

  IUserAccessRefreshTokenClient get userAccessRefreshTokenClient =>
      get<IUserAccessRefreshTokenClient>();
}
