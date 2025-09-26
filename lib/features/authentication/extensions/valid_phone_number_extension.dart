extension ValidPhoneNumberExtension on String? {
  bool get isValidPhoneNumber {
    final value = this;
    return value != null && (value.isNotEmpty && value.length > 10);
  }
}
