import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/services/secure_storage/service_locator/secure_storage_service_di_extensions.dart';
import '../abstract_user_access_token_storage.dart';
import '../user_token_storage.dart';

extension UserTokenStorageDiExtensions on GetIt {
  GetIt registerUserTokenStorage({required String keyAccessToken}) {
    registerLazySingleton<IUserAccessTokenStorage>(
      () => UserAccessTokenStorage(
        storage: secureStorageService,
        keyAccessToken: keyAccessToken,
      ),
    );
    return this;
  }

  IUserAccessTokenStorage get userAccessTokenStorage =>
      get<IUserAccessTokenStorage>();
}
