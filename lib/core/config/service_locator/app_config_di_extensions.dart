import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/config/abstract_app_config.dart';
import 'package:imove_challenge/core/config/app_config.dart';

extension AppConfigDiExtensions on GetIt {
  GetIt registerAppConfig() {
    registerLazySingleton<IAppConfig>(() => AppConfig());
    return this;
  }

  IAppConfig get appConfig => get<IAppConfig>();
}
