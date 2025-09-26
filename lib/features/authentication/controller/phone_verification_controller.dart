import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:imove_challenge/core/widgets/toast/failure_toast.dart';
import 'package:imove_challenge/core/widgets/toast/toast.dart';
import 'package:imove_challenge/router/constants/router_names/authorization_route_names.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_state.dart';

class PhoneVerificationController {
  void handleState({
    required AuthenticationState state,
    required BuildContext context,
    required String identity,
    required String userType,
  }) {
    if (state is SendPhoneNumberSuccessState) {
      context.pushNamed(
        AuthorizationRouteNames.otpCode,
        queryParameters: {
          'verificationId': state.verificationId,
          'userType': userType,
          'identity': identity,
        },
      );
    }
    if (state is SendPhoneNumberErrorState) {
      EightToast.show(
        context,
        builder: (context) =>
            FailureToast(label: state.error.message ?? 'Something went wrong. Try again.'),
      );
    }
    if (state is UnknownErrorState) {
      EightToast.show(
        context,
        builder: (context) => FailureToast(label: 'Something went wrong. Try again.'),
      );
    }
  }
}
