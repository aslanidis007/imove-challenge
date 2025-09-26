import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/services/resilience/service_locator/resilience_exectur_di_extensions.dart';
import 'package:imove_challenge/features/rides/repositories/pre_resilience_rides_repository.dart';
import 'package:imove_challenge/features/rides/api_clients/service_locator/rides_api_client_di_extensions.dart';

import 'package:imove_challenge/features/rides/repositories/abstract_rides_repository.dart';
import 'package:imove_challenge/features/rides/repositories/rides_repository.dart';

extension RidesRepositoryDiExtensions on GetIt {
  GetIt registerRidesRepository() {
    registerLazySingleton<IRidesRepository>(() {
      final baseRidesRepository = RidesRepository(apiClient: ridesApiClient);

      final preResilienceRidesRepository = PreResilienceRidesRepository(
        repository: baseRidesRepository,
        resilientExecutor: resilienceExecutor,
      );

      return preResilienceRidesRepository;
    });
    return this;
  }
}
