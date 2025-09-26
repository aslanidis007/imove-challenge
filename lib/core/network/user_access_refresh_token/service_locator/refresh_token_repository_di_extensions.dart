import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/api_clients/service_locator/user_access_refresh_token_client_di_extensions.dart';
import 'package:imove_challenge/core/services/resilience/service_locator/resilience_exectur_di_extensions.dart';

import '../repository/abstract_refresh_token_repository.dart';
import '../repository/pre_resilience_refresh_token_repository.dart';
import '../repository/refresh_token_repository.dart';

extension RefreshTokenRepositoryDiExtensions on GetIt {
  GetIt registerRefreshTokenRepository() {
    registerLazySingleton<IRefreshTokenRepository>(() {
      final baseRepository = RefreshTokenRepository(
        userAccessRefreshTokenClient: userAccessRefreshTokenClient,
      );

      final preResilienceRepository = PreResilienceRefreshTokenRepository(
        repository: baseRepository,
        resilientExecutor: resilienceExecutor,
      );

      return preResilienceRepository;
    });

    return this;
  }

  IRefreshTokenRepository get refreshTokenRepository => get<IRefreshTokenRepository>();
}
