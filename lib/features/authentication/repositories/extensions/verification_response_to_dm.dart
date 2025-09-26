import 'package:imove_challenge/features/authentication/repositories/models/verification_response_dm.dart';
import 'package:imove_challenge/features/authentication/api_clients/models/verification_response_rm.dart';

extension VerificationResponseRmToDm on VerificationResponseRm {
  VerificationResponseDm toDm() => VerificationResponseDm(verificationId: verificationId);
}
