import 'dart:convert';

import '../models/auth_token.dart';

class ParseToken {
  ParseToken._();
  static OAuth2Token? parseToken(String tokenString) {
    try {
      final tokenData = json.decode(tokenString) as Map<String, dynamic>?;

      if (tokenData != null && tokenData['value'] != null) {
        return OAuth2Token(
          accessToken: tokenData['value'] as String,
          refreshToken: tokenData['refreshToken'] as String?,
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
