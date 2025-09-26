import 'package:imove_challenge/core/network/errors/models/validation_api_error.dart';
import 'package:imove_challenge/features/authentication/repositories/models/authentication_dm.dart';
import 'package:imove_challenge/features/authentication/repositories/models/verification_dm.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imove_challenge/features/authentication/repositories/abstract_authentication_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthenticationRepository _authenticationRepository;
  AuthenticationBloc({required IAuthenticationRepository authenticationRepository})
    : _authenticationRepository = authenticationRepository,
      super(AuthenticationInitialState()) {
    on<SendPhoneNumberEvent>(_onSendPhoneNumber);
    on<VerifyOtpCodeEvent>(_onVerifyOtpCode);
  }

  Future<void> _onSendPhoneNumber(
    SendPhoneNumberEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoadingState());
    final result = await _authenticationRepository.verifyPhoneNumber(
      VerificationDm(identity: event.phoneNumber, userType: event.userType),
    );
    result.fold(
      (data) {
        emit(SendPhoneNumberSuccessState(verificationId: data.verificationId));
      },
      (error) {
        if (error is ValidationApiError) {
          emit(SendPhoneNumberErrorState(error: error));
        } else {
          emit(UnknownErrorState());
        }
      },
    );
  }

  Future<void> _onVerifyOtpCode(VerifyOtpCodeEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    final result = await _authenticationRepository.authenticate(
      AuthenticationDm(
        identity: event.identity,
        code: event.code,
        verificationId: event.verificationId,
        userType: event.userType,
      ),
    );
    result.fold(
      (data) {
        emit(VerifyOtpCodeSuccessState());
      },
      (error) {
        if (error is ValidationApiError) {
          emit(VerifyOtpCodeErrorState(error: error));
        } else {
          emit(UnknownErrorState());
        }
      },
    );
  }
}
