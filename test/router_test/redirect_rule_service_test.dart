import 'package:flutter_test/flutter_test.dart';
import 'package:imove_challenge/core/network/models/auth_token.dart';
import 'package:imove_challenge/core/network/token_storage/abstract_user_access_token_storage.dart';
import 'package:imove_challenge/router/constants/router_paths/authorization_route_paths.dart';
import 'package:imove_challenge/router/constants/router_paths/ride_route_names.dart';
import 'package:imove_challenge/router/exceptions/app_router_exceptions.dart';
import 'package:imove_challenge/router/services/redirect_rule_services.dart';
import 'package:result_dart/result_dart.dart';

class FakeTokenStorage implements IUserAccessTokenStorage {
  bool _isLoggedIn = false;

  void setLoggedIn(bool loggedIn) => _isLoggedIn = loggedIn;

  @override
  AsyncResult<Unit> isLoggedIn() async =>
      _isLoggedIn ? const Success(unit) : Failure(Exception('Not logged in'));

  @override
  AsyncResult<OAuth2Token> read() async => throw UnimplementedError();

  @override
  AsyncResult<Unit> write(dynamic token) async => throw UnimplementedError();

  @override
  AsyncResult<Unit> delete() async => throw UnimplementedError();
}

void main() {
  group('RedirectRuleServices Tests', () {
    late RedirectRuleServices service;
    late FakeTokenStorage fakeTokenStorage;

    setUp(() {
      fakeTokenStorage = FakeTokenStorage();
      service = RedirectRuleServices(userAccessTokenStorage: fakeTokenStorage);
    });

    test(
      'Should redirect to rides when user is logged in and on phone verification page',
      () async {
        // Setup
        fakeTokenStorage.setLoggedIn(true);
        final targetUri = Uri.parse(AuthorizationRoutePaths.phoneVerification);

        // Act
        final result = await service.appRedirectRule(targetUri);

        // Assert
        expect(result.isSuccess(), true);
        expect(result.getOrNull(), RideRoutePaths.rides);
      },
    );

    test('Should fail when user is NOT logged in on phone verification page', () async {
      // Setup
      fakeTokenStorage.setLoggedIn(false);
      final targetUri = Uri.parse(AuthorizationRoutePaths.phoneVerification);

      // Act
      final result = await service.appRedirectRule(targetUri);

      // Assert
      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<AppRouterRedirectException>());
    });

    test('Should fail when user is logged in but NOT on phone verification page', () async {
      // Setup
      fakeTokenStorage.setLoggedIn(true);
      final targetUri = Uri.parse('/some/other/page');

      // Act
      final result = await service.appRedirectRule(targetUri);

      // Assert
      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<AppRouterRedirectException>());
    });

    test('Should fail when user is NOT logged in and NOT on phone verification page', () async {
      // Setup
      fakeTokenStorage.setLoggedIn(false);
      final targetUri = Uri.parse('/some/other/page');

      // Act
      final result = await service.appRedirectRule(targetUri);

      // Assert
      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<AppRouterRedirectException>());
    });

    test('Should handle empty path correctly', () async {
      // Setup
      fakeTokenStorage.setLoggedIn(true);
      final targetUri = Uri.parse('');

      // Act
      final result = await service.appRedirectRule(targetUri);

      // Assert
      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<AppRouterRedirectException>());
    });

    test('Should handle root path correctly', () async {
      // Setup
      fakeTokenStorage.setLoggedIn(false);
      final targetUri = Uri.parse('/');

      // Act
      final result = await service.appRedirectRule(targetUri);

      // Assert
      expect(result.isError(), true);
      expect(result.exceptionOrNull(), isA<AppRouterRedirectException>());
    });
  });
}
