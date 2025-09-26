import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';

class AuthenticationResponseRm extends Equatable {
  final String accessToken;
  final String? refreshToken;
  final String? tokenExpiryTime;
  final String? refreshTokenExpiryTime;

  AuthenticationResponseRm({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenExpiryTime,
    required this.refreshTokenExpiryTime,
  }) {
    Guard.against.nullOrWhitespace(accessToken, name: 'accessToken');
    Guard.against.notWhitespace(refreshToken, name: 'refreshToken');
    Guard.against.notWhitespace(tokenExpiryTime, name: 'tokenExpiryTime');
    Guard.against.notWhitespace(refreshTokenExpiryTime, name: 'refreshTokenExpiryTime');
  }

  factory AuthenticationResponseRm.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return AuthenticationResponseRm(
      accessToken: data['token'] as String,
      refreshToken: data['refreshToken'] as String?,
      tokenExpiryTime: data['tokenExpiryTime'] as String?,
      refreshTokenExpiryTime: data['refreshTokenExpiryTime'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'accessToken': accessToken, 'refreshToken': refreshToken};

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
