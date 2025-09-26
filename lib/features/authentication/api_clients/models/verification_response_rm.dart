import 'package:equatable/equatable.dart';
import 'package:imove_challenge/core/utils/common/extensions/guard_extensions.dart';
import 'package:imove_challenge/core/utils/common/guard.dart';

class VerificationResponseRm extends Equatable {
  final String verificationId;
  final bool succeeded;
  final int? errorCode;
  final String? errorMessage;
  final List<String>? errorMessages;

  VerificationResponseRm({
    required this.verificationId,
    required this.succeeded,
    this.errorCode,
    this.errorMessage,
    this.errorMessages,
  }) {
    Guard.against.nullOrWhitespace(verificationId, name: 'verificationId');
  }

  factory VerificationResponseRm.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return VerificationResponseRm(
      verificationId: data['verificationId'] as String,
      succeeded: json['succeeded'] as bool,
      errorCode: json['error']['code'] as int?,
      errorMessage: json['error']['message'] as String?,
      errorMessages: (json['error']['messages'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'verificationId': verificationId,
    'succeeded': succeeded,
    'error': {'code': errorCode, 'message': errorMessage, 'messages': errorMessages},
  };

  @override
  List<Object?> get props => [verificationId, succeeded, errorCode, errorMessage, errorMessages];
}
