import 'package:imove_challenge/core/network/extensions/api_response_nullable_extensions.dart';
import 'package:result_dart/result_dart.dart';

import 'package:imove_challenge/core/network/clients/abstract_core_dio_client.dart';
import 'abstract_authentication_api_client.dart';
import 'exceptions/authentication_exceptions.dart';
import 'models/authentication_rm.dart';
import 'models/authentication_response_rm.dart';
import 'abstract_authentication_url_builder.dart';
import 'models/verification_response_rm.dart';
import 'models/verification_rm.dart';

class AuthenticationApiClient implements IAuthenticationApiClient {
  final IAuthenticationUrlBuilder _urlBuilder;
  final ICoreDioClient _httpClient;

  AuthenticationApiClient({
    required IAuthenticationUrlBuilder urlBuilder,
    required ICoreDioClient httpClient,
  }) : _urlBuilder = urlBuilder,
       _httpClient = httpClient;

  @override
  AsyncResult<AuthenticationResponseRm> authenticate(AuthenticationRm authenticationRm) async {
    final result = await _httpClient.post(
      url: _urlBuilder.authenticateUrl,
      data: authenticationRm.toJson(),
    );
    final response = result.getOrNull();
    return response.isSuccessStatusCode && response?.data['data'] != null
        ? Success(AuthenticationResponseRm.fromJson(response?.data as Map<String, dynamic>))
        : Failure(
            result.exceptionOrNull() ?? AuthenticationApiClientException("Something went wrong"),
          );
  }

  @override
  AsyncResult<VerificationResponseRm> verifyPhoneNumber(VerificationRm verificationRm) async {
    final result = await _httpClient.post(
      url: _urlBuilder.verifyUrl,
      data: verificationRm.toJson(),
    );
    final response = result.getOrNull();

    return response.isSuccessStatusCode
        ? Success(VerificationResponseRm.fromJson(response?.data as Map<String, dynamic>))
        : Failure(
            result.exceptionOrNull() ?? AuthenticationApiClientException("Something went wrong"),
          );
  }
}
