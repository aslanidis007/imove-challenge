import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import '../../../../utils/common/guard.dart';

class RefreshTokenDm extends Equatable {
  final String? refreshToken;
  final String token;

  RefreshTokenDm({required this.refreshToken, required this.token}) {
    Guard.against.nullOrWhitespace(token, name: 'token');
    Guard.against.notWhitespace(refreshToken, name: 'refreshToken');
  }

  factory RefreshTokenDm.fromJson(Map<String, dynamic> json) {
    return RefreshTokenDm(
      refreshToken: json['refreshToken'] as String?,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    'refreshToken': refreshToken,
  };

  @override
  List<Object?> get props => [token, refreshToken];
}
