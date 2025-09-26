import 'package:get_it/get_it.dart';
import 'package:imove_challenge/router/abstract_app_router.dart';
import 'package:imove_challenge/router/app_router.dart';
import 'package:imove_challenge/router/service_locator/redirect_rule_di_extensions.dart';

extension AppRouterDiExtensions on GetIt {
  GetIt registerAppRouter() {
    registerLazySingleton<IAppRouter>(() => AppRouter(redirectRuleServices: redirectRuleServices));
    return this;
  }

  IAppRouter get appRouter => get<IAppRouter>();
}
