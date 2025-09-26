import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';

class AuthenticationResponseDm extends Equatable {
  final String accessToken;
  final String? refreshToken;

  AuthenticationResponseDm({required this.accessToken, required this.refreshToken}) {
    Guard.against.nullOrWhitespace(accessToken, name: 'accessToken');
    Guard.against.notWhitespace(refreshToken, name: 'refreshToken');
  }

  factory AuthenticationResponseDm.fromJson(Map<String, dynamic> json) {
    return AuthenticationResponseDm(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {'accessToken': accessToken, 'refreshToken': refreshToken};

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
