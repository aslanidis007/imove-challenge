import 'package:imove_challenge/features/authentication/api_clients/models/authentication_rm.dart';
import 'package:imove_challenge/features/authentication/repositories/models/authentication_dm.dart';

extension AuthenticationDmToRm on AuthenticationDm {
  AuthenticationRm toRm() => AuthenticationRm(
    identity: identity,
    code: code,
    verificationId: verificationId,
    userType: userType,
  );
}
