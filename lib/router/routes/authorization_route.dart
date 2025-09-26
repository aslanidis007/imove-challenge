import 'package:go_router/go_router.dart';
import 'package:imove_challenge/features/authentication/view/otp_code_view.dart';
import 'package:imove_challenge/features/authentication/view/phone_verification_view.dart';
import 'package:imove_challenge/router/constants/router_names/authorization_route_names.dart';
import 'package:imove_challenge/router/constants/router_params/otp_code_params.dart';
import 'package:imove_challenge/router/constants/router_paths/authorization_route_paths.dart';

class AuthorizationRoute {
  GoRoute get authorizationRoute => GoRoute(
    path: AuthorizationRoutePaths.phoneVerification,
    name: AuthorizationRouteNames.phoneVerification,
    builder: (context, state) => const PhoneVerificationView(),
  );
  GoRoute get otpCodeRoute => GoRoute(
    path: AuthorizationRoutePaths.otpCode,
    name: AuthorizationRouteNames.otpCode,
    builder: (context, state) {
      final otpCodeParams = state.otpCodeParams;
      return OtpCodeView(
        verificationId: otpCodeParams.verificationId,
        userType: otpCodeParams.userType,
        identity: otpCodeParams.identity,
      );
    },
  );
}
