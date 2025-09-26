import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/services/resilience/abstract_resilient_executor.dart';
import 'package:imove_challenge/core/services/resilience/resilience_executor.dart';

extension ResilienceExecutorDiExtensions on GetIt {
  void registerResilienceExecutor() {
    registerLazySingleton<IResilientExecutor>(() => ResilientExecutor());
  }

  IResilientExecutor get resilienceExecutor => get<IResilientExecutor>();
}
