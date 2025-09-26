import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/token_storage/service_locator/user_token_storage_di_extensions.dart';
import 'package:imove_challenge/core/services/resilience/service_locator/resilience_exectur_di_extensions.dart';
import 'package:imove_challenge/features/authentication/api_clients/service_locator/authentication_api_client_di_extensions.dart';
import 'package:imove_challenge/features/authentication/repositories/pre_resilience_authentication_repository.dart';

import 'package:imove_challenge/features/authentication/repositories/abstract_authentication_repository.dart';
import 'package:imove_challenge/features/authentication/repositories/authentication_repository.dart';

extension AuthenticationRepositoryDiExtensions on GetIt {
  GetIt registerAuthenticationRepository() {
    registerLazySingleton<IAuthenticationRepository>(() {
      final baseAuthenticationRepository = AuthenticationRepository(
        apiClient: authenticationApiClient,
        userAccessTokenStorage: userAccessTokenStorage,
      );

      final preResilienceAuthenticationRepository = PreResilienceAuthenticationRepository(
        repository: baseAuthenticationRepository,
        resilientExecutor: resilienceExecutor,
      );

      return preResilienceAuthenticationRepository;
    });
    return this;
  }
}
