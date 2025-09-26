import 'package:result_dart/result_dart.dart';

import 'models/authentication_dm.dart';
import 'models/authentication_response_dm.dart';
import 'models/verification_dm.dart';
import 'models/verification_response_dm.dart';

abstract class IAuthenticationRepository {
  AsyncResult<AuthenticationResponseDm> authenticate(AuthenticationDm authenticationDm);

  AsyncResult<VerificationResponseDm> verifyPhoneNumber(VerificationDm verificationDm);
}
