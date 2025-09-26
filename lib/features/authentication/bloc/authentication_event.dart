import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitialEvent extends AuthenticationEvent {}

class SendPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumber;
  final int userType;

  const SendPhoneNumberEvent({required this.phoneNumber, required this.userType});

  @override
  List<Object?> get props => [phoneNumber, userType];
}

class VerifyOtpCodeEvent extends AuthenticationEvent {
  final String identity;
  final String code;
  final String verificationId;
  final int userType;

  const VerifyOtpCodeEvent({
    required this.identity,
    required this.code,
    required this.verificationId,
    required this.userType,
  });

  @override
  List<Object?> get props => [identity, code, verificationId, userType];
}
