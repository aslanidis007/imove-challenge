import 'package:result_dart/result_dart.dart';

import '../../clients/abstract_core_dio_client.dart';
import '../../models/auth_token.dart';
import 'abstract_user_access_refresh_token_builder.dart';
import 'abstract_user_access_refresh_token_client.dart';
import 'exceptions/user_access_refresh_token_client_exceptions.dart';
import 'models/refresh_token_rm.dart';

class UserAccessRefreshTokenClient implements IUserAccessRefreshTokenClient {
  final ICoreDioClient _coreDioClient;
  final IUserAccessRefreshTokenBuilder _userAccessRefreshTokenBuilder;

  UserAccessRefreshTokenClient({
    required ICoreDioClient coreDioClient,
    required IUserAccessRefreshTokenBuilder userAccessRefreshTokenBuilder,
  }) : _userAccessRefreshTokenBuilder = userAccessRefreshTokenBuilder,
       _coreDioClient = coreDioClient;

  @override
  AsyncResult<OAuth2Token> refreshToken(RefreshTokenRm refreshTokenRm) async {
    final result = await _coreDioClient.post(
      url: _userAccessRefreshTokenBuilder.refreshTokenUrl,
      data: refreshTokenRm.toJson(),
    );
    final response = result.getOrNull()?.data as Map<String, dynamic>?;
    return response != null
        ? Success(OAuth2Token.fromJson(response))
        : Failure(
            UserAccessRefreshTokenClientException(
              "RefreshToken.Something went wrong ${result.exceptionOrNull()}",
            ),
          );
  }
}
