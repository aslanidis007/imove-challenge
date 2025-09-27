import 'package:flutter_test/flutter_test.dart';
import 'package:imove_challenge/core/network/models/auth_token.dart';
import 'package:imove_challenge/core/network/token_storage/abstract_user_access_token_storage.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/repository/abstract_refresh_token_repository.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/repository/models/refresh_token_dm.dart';
import 'package:imove_challenge/core/services/refresh_token/user_access_token/refresh_user_access_token_service.dart';
import 'package:result_dart/result_dart.dart';
import 'package:dio/dio.dart';

class MockTokenStorage implements IUserAccessTokenStorage {
  OAuth2Token? _token;
  bool readCalled = false;
  bool writeCalled = false;

  void setToken(OAuth2Token? token) => _token = token;

  @override
  AsyncResult<OAuth2Token> read() async {
    readCalled = true;
    return _token != null ? Success(_token!) : Failure(Exception('No token'));
  }

  @override
  AsyncResult<Unit> write(OAuth2Token token) async {
    writeCalled = true;
    _token = token;
    return const Success(unit);
  }

  @override
  AsyncResult<Unit> delete() async => const Success(unit);

  @override
  AsyncResult<Unit> isLoggedIn() async => const Success(unit);
}

class MockRefreshRepository implements IRefreshTokenRepository {
  bool refreshCalled = false;
  int callCount = 0;

  @override
  AsyncResult<OAuth2Token> refreshToken(RefreshTokenDm body) async {
    refreshCalled = true;
    callCount++;

    return Success(
      OAuth2Token(accessToken: 'new_token_$callCount', refreshToken: 'new_refresh_$callCount'),
    );
  }
}

void main() {
  group('Simple Refresh Service Tests', () {
    late RefreshUserAccessTokenService service;
    late MockTokenStorage tokenStorage;
    late MockRefreshRepository refreshRepo;

    setUp(() {
      tokenStorage = MockTokenStorage();
      refreshRepo = MockRefreshRepository();

      service = RefreshUserAccessTokenService(
        tokenStorage: tokenStorage,
        refreshTokenRepository: refreshRepo,
        dio: Dio(),
      );
    });

    test('Service creates interceptor', () {
      final interceptor = service.createAuthInterceptor();
      expect(interceptor, isA<InterceptorsWrapper>());
    });

    test('Token storage can store and retrieve tokens', () async {
      final token = OAuth2Token(accessToken: 'test_access', refreshToken: 'test_refresh');

      await tokenStorage.write(token);
      expect(tokenStorage.writeCalled, true);

      final result = await tokenStorage.read();
      expect(tokenStorage.readCalled, true);
      expect(result.getOrNull()?.accessToken, 'test_access');
    });

    test('Refresh repository can refresh tokens', () async {
      final refreshToken = RefreshTokenDm(token: 'old_token', refreshToken: 'old_refresh');

      final result = await refreshRepo.refreshToken(refreshToken);

      expect(refreshRepo.refreshCalled, true);
      expect(refreshRepo.callCount, 1);
      expect(result.getOrNull()?.accessToken, 'new_token_1');
    });

    test('Multiple refresh calls increment counter', () async {
      final refreshToken = RefreshTokenDm(token: 'old_token', refreshToken: 'old_refresh');

      await refreshRepo.refreshToken(refreshToken);
      await refreshRepo.refreshToken(refreshToken);

      expect(refreshRepo.callCount, 2);
    });
  });
}
