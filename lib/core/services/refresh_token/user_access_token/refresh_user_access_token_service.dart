import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:imove_challenge/core/network/models/auth_token.dart';
import 'package:imove_challenge/core/network/token_storage/abstract_user_access_token_storage.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/repository/abstract_refresh_token_repository.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/repository/models/refresh_token_dm.dart';
import 'package:imove_challenge/core/services/refresh_token/exceptions/refresh_token_exceptions.dart';
import 'package:result_dart/result_dart.dart';

import 'abstract_refresh_user_access_token_service.dart';

class RefreshUserAccessTokenService implements IRefreshUserAccessTokenService {
  final IUserAccessTokenStorage _tokenStorage;
  final IRefreshTokenRepository _refreshTokenRepository;
  final Dio _dio;

  // Use Completer to ensure single refresh operation with proper synchronization
  Completer<OAuth2Token?>? _refreshCompleter;
  bool _isRefreshing = false;
  final int _maxRetryAttempts = 1;

  RefreshUserAccessTokenService({
    required IUserAccessTokenStorage tokenStorage,
    required IRefreshTokenRepository refreshTokenRepository,
    required Dio dio,
  }) : _tokenStorage = tokenStorage,
       _refreshTokenRepository = refreshTokenRepository,
       _dio = dio;

  @override
  InterceptorsWrapper createAuthInterceptor() => InterceptorsWrapper(
    onRequest: (options, handler) async {
      await _handleRequest(options, handler);
    },
    onError: (error, handler) async {
      await _handleError(error, handler);
    },
  );

  AsyncResult<Unit> _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final tokenFromStorage = await _tokenStorage.read().getOrNull();

      if (tokenFromStorage == null) {
        handler.reject(
          DioException(
            requestOptions: options,
            response: Response(
              requestOptions: options,
              statusCode: 401,
              statusMessage: 'No access token available',
            ),
            type: DioExceptionType.badResponse,
          ),
        );
        return Failure(RefreshTokenException("No access token available. Please login."));
      }

      _addTokenToHeaders(options, tokenFromStorage.accessToken);
      handler.next(options);
      return const Success(unit);
    } catch (e) {
      handler.reject(
        DioException(requestOptions: options, error: e, type: DioExceptionType.unknown),
      );
      return Failure(RefreshTokenException("Authentication failed: $e"));
    }
  }

  AsyncResult<OAuth2Token> _performTokenRefresh(OAuth2Token currentToken) async {
    if (_isRefreshing) {
      if (_refreshCompleter != null) {
        final result = await _refreshCompleter!.future;
        return result != null
            ? Success(result)
            : Failure(RefreshTokenException("Error refreshing token"));
      } else {
        // This shouldn't happen, but handle it gracefully
        _isRefreshing = false;
        // Try again after resetting the state
        return await _performTokenRefresh(currentToken);
      }
    }

    // Start new refresh operation atomically
    _isRefreshing = true;
    _refreshCompleter = Completer<OAuth2Token?>();

    try {
      final result = await _handleRefreshToken(currentToken);

      return await result.fold(
        (newToken) async {
          await _tokenStorage.write(newToken);
          _refreshCompleter!.complete(newToken);
          return Success(newToken);
        },
        (error) async {
          _refreshCompleter!.complete(null);
          return Failure(error);
        },
      );
    } catch (e) {
      // Complete all waiting requests with null (failure)
      _refreshCompleter!.complete(null);
      return Failure(RefreshTokenException("Error refreshing token: $e"));
    } finally {
      // Reset state atomically
      _isRefreshing = false;
      _refreshCompleter = null;
    }
  }

  AsyncResult<Unit> _handleError(DioException error, ErrorInterceptorHandler handler) async {
    // Check if this is a retry attempt to avoid infinite loops
    final retryCount = error.requestOptions.extra['_auth_retry_count'] as int? ?? 0;

    if (error.response?.statusCode == 401 && retryCount < _maxRetryAttempts) {
      final currentToken = await _tokenStorage.read().getOrNull();

      if (currentToken != null) {
        final newTokenResult = await _performTokenRefresh(currentToken);

        return await newTokenResult.fold(
          (newToken) async {
            try {
              // Retry original request with new token
              final clonedRequest = error.requestOptions;
              _addTokenToHeaders(clonedRequest, newToken.accessToken);

              // Mark this as a retry attempt to prevent infinite loops
              clonedRequest.extra['_auth_retry_count'] = retryCount + 1;

              // Use a clean Dio instance for retry to avoid interceptor conflicts
              final response = await _retryRequest(clonedRequest);
              handler.resolve(response);
              return const Success(unit);
            } catch (retryError) {
              // If retry fails, forward the original error
              handler.next(error);
              return Failure(RefreshTokenException("Retry failed: $retryError"));
            }
          },
          (refreshError) async {
            // If refresh fails, forward the original error
            handler.next(error);
            return Failure(refreshError);
          },
        );
      }
    }

    handler.next(error);
    return const Success(unit);
  }

  Future<Response> _retryRequest(RequestOptions options) async {
    // Create a temporary Dio instance with the same base options but without interceptors
    final tempDio = Dio(_dio.options)
      ..options = _dio.options.copyWith()
      ..interceptors.clear();

    return await tempDio.fetch(options);
  }

  void _addTokenToHeaders(RequestOptions options, String accessToken) {
    options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
  }

  AsyncResult<OAuth2Token> _handleRefreshToken(OAuth2Token? token) async {
    if (token == null || token.refreshToken == null) {
      return Failure(RefreshTokenException('No refresh token available'));
    }

    final refreshTokenDm = RefreshTokenDm(
      token: token.accessToken,
      refreshToken: token.refreshToken,
    );

    try {
      final result = await _refreshTokenRepository.refreshToken(refreshTokenDm);
      return result.fold(
        (newToken) => Success(newToken),
        (error) => Failure(RefreshTokenException('Refresh token request failed: $error')),
      );
    } catch (e) {
      return Failure(RefreshTokenException('Refresh token request failed: $e'));
    }
  }
}
