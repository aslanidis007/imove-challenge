import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import '../../../../utils/common/guard.dart';

class RefreshTokenRm extends Equatable {
  final String token;
  final String? refreshToken;

  RefreshTokenRm({required this.token, required this.refreshToken}) {
    Guard.against.nullOrWhitespace(token, name: 'token');
    Guard.against.notWhitespace(refreshToken, name: 'refreshToken');
  }

  factory RefreshTokenRm.fromJson(Map<String, dynamic> json) {
    return RefreshTokenRm(
      token: json['token'] as String,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
  };

  @override
  List<Object?> get props => [token, refreshToken];
}
