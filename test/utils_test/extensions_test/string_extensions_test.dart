import 'package:flutter_test/flutter_test.dart';
import 'package:imove_challenge/core/utils/extensions/string_extensions.dart';

void main() {
  group('StringExtension buildUrl Tests', () {
    test('Returns original URL when no query parameters provided', () {
      const url = 'https://example.com/path';

      final result1 = url.buildUrl();
      final result2 = url.buildUrl(queryParameters: {});

      expect(result1, 'https://example.com/path');
      expect(result2, 'https://example.com/path');
    });

    test('Adds new query parameters to URL without existing params', () {
      const url = 'https://example.com/path';

      final result = url.buildUrl(queryParameters: {'name': 'John', 'age': '25'});

      expect(result, 'https://example.com/path?name=John&age=25');
    });

    test('Merges with existing query parameters (new ones override)', () {
      const url = 'https://example.com/path?existing=old&keep=this';

      final result = url.buildUrl(queryParameters: {'existing': 'new', 'added': 'param'});

      expect(result, 'https://example.com/path?existing=new&keep=this&added=param');
    });

    test('Handles null values as empty strings', () {
      const url = 'https://example.com/path';

      final result = url.buildUrl(queryParameters: {'token': null, 'name': 'John'});

      expect(result, 'https://example.com/path?token=&name=John');
    });

    test('Handles empty and whitespace-only values', () {
      const url = 'https://example.com/path';

      final result = url.buildUrl(
        queryParameters: {'empty': '', 'spaces': '   ', 'tab': '\t', 'normal': 'value'},
      );

      expect(result, 'https://example.com/path?empty=&spaces=&tab=&normal=value');
    });

    test('Trims whitespace from values', () {
      const url = 'https://example.com/path';

      final result = url.buildUrl(queryParameters: {'trimmed': '  value  ', 'normal': 'test'});

      expect(result, 'https://example.com/path?trimmed=value&normal=test');
    });

    test('Throws ArgumentError for invalid URLs', () {
      const invalidUrl = 'not-a-valid-url';

      expect(
        () => invalidUrl.buildUrl(queryParameters: {'key': 'value'}),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Throws ArgumentError for relative URLs', () {
      const relativeUrl = '/relative/path';

      expect(
        () => relativeUrl.buildUrl(queryParameters: {'key': 'value'}),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Preserves port numbers and schemes', () {
      const url = 'http://localhost:3000/api';

      final result = url.buildUrl(queryParameters: {'debug': 'true'});

      expect(result, 'http://localhost:3000/api?debug=true');
    });
  });
}
