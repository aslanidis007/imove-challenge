import 'package:flutter_test/flutter_test.dart';
import 'package:imove_challenge/core/constants/reg_exp_helper.dart';

void main() {
  group('RegExpHelper Tests', () {
    test('Valid phone numbers should match', () {
      // Basic numbers
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('1234567890'), true);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('6912345678'), true);

      // With plus prefix
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('+1234567890'), true);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('+306912345678'), true);

      // Single digit
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('1'), true);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('+1'), true);

      // Empty string (technically matches the pattern)
      expect(RegExpHelper.phoneNumberRegExp.hasMatch(''), true);
    });

    test('Invalid phone numbers should not match', () {
      // Contains letters
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123abc456'), false);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('phone123'), false);

      // Contains special characters (except +)
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123-456-789'), false);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123 456 789'), false);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('(123)456789'), false);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123.456.789'), false);

      // Multiple plus signs
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('++1234567890'), false);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123+456'), false);

      // Plus not at beginning
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123+'), false);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('12+34'), false);
    });

    test('Edge cases', () {
      // Only plus sign
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('+'), true);

      // Very long number
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('123456789012345678901234567890'), true);

      // Greek phone number format
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('6912345678'), true);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('+306912345678'), true);

      // International formats (numbers only)
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('+1234567890123'), true);
      expect(RegExpHelper.phoneNumberRegExp.hasMatch('00306912345678'), true);
    });
  });
}
