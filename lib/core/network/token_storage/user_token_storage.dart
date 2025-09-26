import 'dart:convert';

import 'package:result_dart/result_dart.dart';

import '../../services/secure_storage/abstract_secure_storage_service.dart';
import '../models/auth_token.dart';
import 'abstract_access_token_storage.dart';
import 'abstract_user_access_token_storage.dart';
import 'exceptions/token_storage_exceptions.dart';
import 'parse_token.dart';

class UserAccessTokenStorage implements IAccessTokenStorage, IUserAccessTokenStorage {
  final ISecureStorageService _storage;
  final String _keyAccessToken;

  UserAccessTokenStorage({required ISecureStorageService storage, required String keyAccessToken})
    : _storage = storage,
      _keyAccessToken = keyAccessToken;

  @override
  AsyncResult<Unit> delete() async {
    try {
      await _storage.delete(key: _keyAccessToken);
      return const Success(unit);
    } catch (e) {
      return Failure(TokenStorageException(e.toString()));
    }
  }

  @override
  AsyncResult<OAuth2Token> read() async {
    try {
      final accessTokenFromSecureStorage = await _storage.read(key: _keyAccessToken).getOrNull();

      if (accessTokenFromSecureStorage != null) {
        if (ParseToken.parseToken(accessTokenFromSecureStorage) == null) {
          return Failure(TokenStorageException('Invalid access token'));
        }
        return Success(ParseToken.parseToken(accessTokenFromSecureStorage)!);
      }

      return Failure(TokenStorageException('No access token found'));
    } catch (e) {
      return Failure(TokenStorageException(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> write(OAuth2Token token) async {
    try {
      final Map<String, dynamic> tokenBody = {
        'value': token.accessToken,
        'refreshToken': token.refreshToken,
      };

      await _storage.write(key: _keyAccessToken, value: json.encode(tokenBody));
      return const Success(unit);
    } catch (e) {
      return Failure(TokenStorageException(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> isLoggedIn() async {
    final token = await read();

    final results = await Future.wait([
      _nullOrWhitespaceToken(token.getOrNull()?.accessToken),
      _nullOrWhitespaceToken(token.getOrNull()?.refreshToken),
    ]);

    final isInvalid = results.any((request) => request.isError());

    return isInvalid ? Failure(TokenStorageException('No token found')) : const Success(unit);
  }

  AsyncResult<Unit> _nullOrWhitespaceToken(String? input) async {
    if (input == null || input.trim() == '') {
      return Failure(TokenStorageException('No token found'));
    }
    return const Success(unit);
  }
}
