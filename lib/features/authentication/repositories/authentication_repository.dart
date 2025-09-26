import 'package:imove_challenge/core/network/token_storage/abstract_user_access_token_storage.dart';
import 'package:imove_challenge/features/authentication/api_clients/extensions/authentication_to_rm.dart';
import 'package:imove_challenge/features/authentication/api_clients/extensions/verification_to_rm.dart';
import 'package:imove_challenge/features/authentication/repositories/extensions/authentication_response_to_dm.dart';
import 'package:imove_challenge/features/authentication/repositories/extensions/verification_response_to_dm.dart';
import 'package:result_dart/result_dart.dart';

import 'package:imove_challenge/core/network/models/auth_token.dart';
import 'package:imove_challenge/features/authentication/api_clients/abstract_authentication_api_client.dart';
import 'package:imove_challenge/features/authentication/repositories/abstract_authentication_repository.dart';
import 'models/authentication_dm.dart';
import 'models/authentication_response_dm.dart';
import 'models/verification_dm.dart';
import 'models/verification_response_dm.dart';

class AuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationApiClient _apiClient;
  final IUserAccessTokenStorage _userAccessTokenStorage;

  AuthenticationRepository({
    required IAuthenticationApiClient apiClient,
    required IUserAccessTokenStorage userAccessTokenStorage,
  }) : _apiClient = apiClient,
       _userAccessTokenStorage = userAccessTokenStorage;

  @override
  AsyncResult<AuthenticationResponseDm> authenticate(AuthenticationDm authenticationDm) async {
    final response = await _apiClient.authenticate(authenticationDm.toRm());
    return response.fold((data) async {
      await _userAccessTokenStorage.write(
        OAuth2Token(accessToken: data.accessToken, refreshToken: data.refreshToken),
      );
      return Success(data.toDm());
    }, (error) => Failure(error));
  }

  @override
  AsyncResult<VerificationResponseDm> verifyPhoneNumber(VerificationDm verificationDm) async {
    final response = await _apiClient.verifyPhoneNumber(verificationDm.toRm());
    return response.fold((data) async {
      return Success(data.toDm());
    }, (error) => Failure(error));
  }
}
