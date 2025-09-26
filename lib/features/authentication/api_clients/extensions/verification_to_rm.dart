import 'package:imove_challenge/features/authentication/api_clients/models/verification_rm.dart';
import 'package:imove_challenge/features/authentication/repositories/models/verification_dm.dart';

extension VerificationDmToRm on VerificationDm {
  VerificationRm toRm() => VerificationRm(identity: identity, userType: userType);
}
