import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';

import 'package:imove_challenge/core/utils/common/guard.dart';

class VerificationResponseDm extends Equatable {
  final String verificationId;

  VerificationResponseDm({required this.verificationId}) {
    Guard.against.nullOrWhitespace(verificationId, name: 'verificationId');
  }

  factory VerificationResponseDm.fromJson(Map<String, dynamic> json) {
    return VerificationResponseDm(verificationId: json['verificationId'] as String);
  }

  Map<String, dynamic> toJson() => {'verificationId': verificationId};

  @override
  List<Object?> get props => [verificationId];
}
