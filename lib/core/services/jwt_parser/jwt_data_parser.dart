import 'dart:convert';
import 'abstract_jwt_data_parser.dart';
import 'models/jwt_data.dart';

/// Parses a JWT token and returns the JWT data.
class JwtDataParser implements IJwtDataParser {
  /// Parses a JWT token and returns the JWT data.
  @override
  JWTData parseJwt(String token) {
    // JWT tokens are typically in the format header.payload.signature
    final parts = token.split('.');
    if (parts.length != 3) {
      throw const FormatException('Invalid token format');
    }

    // Decode the payload. JWT payload is base64Url encoded.
    final String normalizedPayload = base64.normalize(parts[1]);
    final payload = json.decode(utf8.decode(base64Url.decode(normalizedPayload)));

    if (payload is! Map<String, dynamic>) {
      throw const FormatException('Invalid payload');
    }

    // Extract user ID από .NET claim
    final userId = payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']
        ?.toString();

    // Extract email από .NET claim
    final email = payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress']
        ?.toString();

    // Extract mobile phone από .NET claim
    final mobilePhone = payload['http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone']
        ?.toString();

    // Extract refresh token ID
    final refreshTokenId = payload['REFRESH_TOKEN_ID_CLAIM']?.toString();

    // Extract role από .NET claim
    final role = payload['http://schemas.microsoft.com/ws/2008/06/identity/claims/role']
        ?.toString();

    // "aud" μπορεί να είναι string ή array
    List<String> aud = [];
    final audRaw = payload['aud'];
    if (audRaw != null) {
      if (audRaw is List) {
        aud = audRaw.map<String>((item) => item.toString()).toList();
      } else if (audRaw is String) {
        aud = [audRaw]; // Single audience as array
      }
    }

    // "exp" should be an integer representing the expiration time (in seconds).
    final expRaw = payload['exp'];
    if (expRaw == null) {
      throw const FormatException('Missing exp field');
    }
    final int expiration = expRaw is int
        ? expRaw
        : int.tryParse(expRaw.toString()) ?? (throw const FormatException('Invalid exp value'));

    // "iss" should be provided as a string.
    final iss = payload['iss']?.toString();
    if (iss == null) {
      throw const FormatException('Missing iss field');
    }

    return JWTData(
      userId: userId,
      email: email,
      mobilePhone: mobilePhone,
      refreshTokenId: refreshTokenId,
      role: role,
      aud: aud,
      expiration: expiration,
      iss: iss,
    );
  }
}
