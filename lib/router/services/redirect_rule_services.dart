import 'package:imove_challenge/core/network/token_storage/abstract_user_access_token_storage.dart';
import 'package:imove_challenge/router/constants/router_paths/authorization_route_paths.dart';
import 'package:imove_challenge/router/constants/router_paths/ride_route_names.dart';
import 'package:imove_challenge/router/exceptions/app_router_exceptions.dart';
import 'package:result_dart/result_dart.dart';

import 'abstract_redirect_rule_services.dart';

class RedirectRuleServices implements IRedirectRuleServices {
  final IUserAccessTokenStorage _userAccessTokenStorage;

  RedirectRuleServices({required IUserAccessTokenStorage userAccessTokenStorage})
    : _userAccessTokenStorage = userAccessTokenStorage;

  @override
  AsyncResult<String> appRedirectRule(Uri targetUri) async {
    final result = await _userAccessTokenStorage.isLoggedIn();
    final isPhoneVerification = targetUri.path == AuthorizationRoutePaths.phoneVerification;

    if (result.isSuccess() && result.getOrNull() != null && isPhoneVerification) {
      return Success(RideRoutePaths.rides);
    }

    return Failure(AppRouterRedirectException());
  }
}
