import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';

class VerificationRm extends Equatable {
  final String identity;
  final int userType;

  VerificationRm({required this.identity, required this.userType}) {
    Guard.against.nullOrWhitespace(identity, name: 'identity');
    Guard.against.negative(userType, name: 'userType');
  }

  factory VerificationRm.fromJson(Map<String, dynamic> json) {
    return VerificationRm(identity: json['identity'] as String, userType: json['userType'] as int);
  }

  Map<String, dynamic> toJson() => {'identity': identity, 'userType': userType};

  @override
  List<Object?> get props => [identity, userType];
}
