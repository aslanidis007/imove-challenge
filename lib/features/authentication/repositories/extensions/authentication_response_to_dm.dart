import 'package:imove_challenge/features/authentication/repositories/models/authentication_response_dm.dart';
import 'package:imove_challenge/features/authentication/api_clients/models/authentication_response_rm.dart';

extension AuthenticationResponseRmToDm on AuthenticationResponseRm {
  AuthenticationResponseDm toDm() =>
      AuthenticationResponseDm(accessToken: accessToken, refreshToken: refreshToken);
}
