import 'package:go_router/go_router.dart';
import 'package:imove_challenge/core/constants/empty_string.dart';

class OtpCodeParams {
  final String verificationId;
  final int userType;
  final String identity;

  OtpCodeParams({required this.verificationId, required this.userType, required this.identity});
}

extension OtpCodeParamsExtension on GoRouterState {
  OtpCodeParams get otpCodeParams {
    final verificationId = uri.queryParameters['verificationId'];
    final userType = uri.queryParameters['userType'];
    final identity = uri.queryParameters['identity'];
    return OtpCodeParams(
      verificationId: verificationId ?? emptyString,
      userType: int.parse(userType ?? '2'),
      identity: identity ?? emptyString,
    );
  }
}
