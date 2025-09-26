import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/token_storage/service_locator/user_token_storage_di_extensions.dart';
import 'package:imove_challenge/router/services/abstract_redirect_rule_services.dart';
import 'package:imove_challenge/router/services/redirect_rule_services.dart';

extension RedirectRuleDiExtensions on GetIt {
  GetIt registerRedirectRuleServices() {
    registerLazySingleton<IRedirectRuleServices>(
      () => RedirectRuleServices(userAccessTokenStorage: userAccessTokenStorage),
    );
    return this;
  }

  IRedirectRuleServices get redirectRuleServices => get<IRedirectRuleServices>();
}
