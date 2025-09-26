import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imove_challenge/router/abstract_app_router.dart';
import 'package:imove_challenge/router/routes/authorization_route.dart';
import 'package:imove_challenge/router/services/abstract_redirect_rule_services.dart';

import 'routes/ride_route.dart';

class AppRouter implements IAppRouter {
  final IRedirectRuleServices _redirectRuleServices;
  AppRouter({required IRedirectRuleServices redirectRuleServices})
    : _redirectRuleServices = redirectRuleServices;

  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'AppRouterRootNavigatorKey');

  @override
  GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) async {
      final result = await _redirectRuleServices.appRedirectRule(state.uri);
      if (result.isSuccess() && result.getOrNull() != null) {
        return result.getOrNull();
      }
      return null;
    },
    routes: [
      AuthorizationRoute().authorizationRoute,
      AuthorizationRoute().otpCodeRoute,
      RideRoute().rideRoute,
    ],
  );
}
