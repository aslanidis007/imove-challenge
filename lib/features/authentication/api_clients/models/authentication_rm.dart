import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';

class AuthenticationRm extends Equatable {
  final String identity;
  final String code;
  final String verificationId;
  final int userType;

  AuthenticationRm({
    required this.identity,
    required this.code,
    required this.verificationId,
    required this.userType,
  }) {
    Guard.against.nullOrWhitespace(identity, name: 'identity');
    Guard.against.nullOrWhitespace(code, name: 'code');
    Guard.against.nullOrWhitespace(verificationId, name: 'verificationId');
    Guard.against.negative(userType, name: 'userType');
  }

  factory AuthenticationRm.fromJson(Map<String, dynamic> json) {
    return AuthenticationRm(
      identity: json['identity'] as String,
      code: json['code'] as String,
      verificationId: json['verificationId'] as String,
      userType: json['userType'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'identity': identity,
    'code': code,
    'verificationId': verificationId,
    'userType': userType,
  };

  @override
  List<Object?> get props => [identity, code, verificationId, userType];
}
