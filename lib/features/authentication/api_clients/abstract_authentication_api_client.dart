import 'package:result_dart/result_dart.dart';

import 'models/authentication_response_rm.dart';
import 'models/authentication_rm.dart';
import 'models/verification_response_rm.dart';
import 'models/verification_rm.dart';

abstract class IAuthenticationApiClient {
  AsyncResult<AuthenticationResponseRm> authenticate(AuthenticationRm authenticationRm);

  AsyncResult<VerificationResponseRm> verifyPhoneNumber(VerificationRm verificationRm);
}
