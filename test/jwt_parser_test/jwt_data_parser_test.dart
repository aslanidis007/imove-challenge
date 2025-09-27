import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:imove_challenge/core/services/jwt_parser/jwt_data_parser.dart';

void main() {
  final parser = JwtDataParser();

  test('Valid JWT with all fields', () {
    final payload = {
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier': 'user123',
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress': 'test@test.com',
      'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/mobilephone': '6912345678',
      'REFRESH_TOKEN_ID_CLAIM': 'refresh123',
      'http://schemas.microsoft.com/ws/2008/06/identity/claims/role': 'Admin',
      'aud': ['app1', 'app2'],
      'exp': 1735689600,
      'iss': 'myapp',
    };

    final header = base64Url.encode(utf8.encode('{}'));
    final payloadEncoded = base64Url.encode(utf8.encode(json.encode(payload)));
    final token = '$header.$payloadEncoded.signature';

    final result = parser.parseJwt(token);

    expect(result.userId, 'user123');
    expect(result.email, 'test@test.com');
    expect(result.role, 'Admin');
    expect(result.aud.length, 2);
  });

  test('Valid JWT with minimal fields', () {
    final payload = {'exp': 1735689600, 'iss': 'myapp'};

    final header = base64Url.encode(utf8.encode('{}'));
    final payloadEncoded = base64Url.encode(utf8.encode(json.encode(payload)));
    final token = '$header.$payloadEncoded.signature';

    final result = parser.parseJwt(token);

    expect(result.userId, null);
    expect(result.email, null);
    expect(result.expiration, 1735689600);
  });

  test('Invalid token format', () {
    expect(() => parser.parseJwt('invalid'), throwsFormatException);
  });

  test('Missing required field', () {
    final payload = {'iss': 'myapp'}; // missing exp

    final header = base64Url.encode(utf8.encode('{}'));
    final payloadEncoded = base64Url.encode(utf8.encode(json.encode(payload)));
    final token = '$header.$payloadEncoded.signature';

    expect(() => parser.parseJwt(token), throwsFormatException);
  });
}
