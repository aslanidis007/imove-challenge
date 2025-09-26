import 'package:equatable/equatable.dart';

import 'package:imove_challenge/core/network/errors/models/validation_api_error.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationLoadingState extends AuthenticationState {}

class UnknownErrorState extends AuthenticationState {}

class SendPhoneNumberSuccessState extends AuthenticationState {
  final String verificationId;

  const SendPhoneNumberSuccessState({required this.verificationId});

  @override
  List<Object?> get props => [verificationId];
}

class SendPhoneNumberErrorState extends AuthenticationState {
  final ValidationApiError error;

  const SendPhoneNumberErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

class VerifyOtpCodeSuccessState extends AuthenticationState {}

class VerifyOtpCodeErrorState extends AuthenticationState {
  final ValidationApiError error;

  const VerifyOtpCodeErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
