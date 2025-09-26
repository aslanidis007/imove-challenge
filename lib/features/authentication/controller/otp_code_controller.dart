import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:imove_challenge/core/widgets/toast/failure_toast.dart';
import 'package:imove_challenge/core/widgets/toast/toast.dart';
import 'package:imove_challenge/router/constants/router_names/ride_route_names.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_state.dart';

class OtpCodeController {
  void handleState({required AuthenticationState state, required BuildContext context}) {
    if (state is VerifyOtpCodeSuccessState) {
      context.goNamed(RideRouteNames.rides);
    }
    if (state is VerifyOtpCodeErrorState) {
      EightToast.show(
        context,
        builder: (context) =>
            FailureToast(label: state.error.message ?? 'Invalid OTP code. Try again.'),
      );
    }
    if (state is UnknownErrorState) {
      EightToast.show(
        context,
        builder: (context) => FailureToast(label: 'Invalid OTP code. Try again.'),
      );
    }
  }
}
