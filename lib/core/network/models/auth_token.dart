import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import '../../utils/common/guard.dart';

class OAuth2Token extends Equatable {
  final String accessToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;

  OAuth2Token({required this.accessToken, this.refreshToken, this.tokenType, this.expiresIn}) {
    Guard.against.nullOrWhitespace(accessToken, name: 'accessToken');
    Guard.against.notWhitespace(refreshToken, name: 'refreshToken');
    Guard.against.notWhitespace(tokenType, name: 'tokenType');
    Guard.against.negativeIfNotNull(expiresIn, name: 'expiresIn');
  }

  factory OAuth2Token.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return OAuth2Token(
      accessToken: data['token'] as String,
      refreshToken: data['refreshToken'] as String?,
      tokenType: data['tokenType'] as String?,
      expiresIn: data['expiresIn'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': accessToken,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken, tokenType, expiresIn];
}
