class JWTData {
  final String? userId;
  final String? email;
  final String? mobilePhone;
  final String? refreshTokenId;
  final String? role;
  final List<String> aud;
  final int expiration;
  final String iss;

  JWTData({
    this.userId,
    this.email,
    this.mobilePhone,
    this.refreshTokenId,
    this.role,
    required this.aud,
    required this.expiration,
    required this.iss,
  });

  @override
  String toString() {
    return 'JWTData(userId: $userId, email: $email, mobilePhone: $mobilePhone, refreshTokenId: $refreshTokenId, role: $role, aud: $aud, expiration: $expiration, iss: $iss)';
  }
}
