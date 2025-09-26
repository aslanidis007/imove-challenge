import 'package:imove_challenge/core/network/user_access_refresh_token/extensions/refresh_token_to_rm.dart';
import 'package:result_dart/result_dart.dart';

import '../../models/auth_token.dart';
import '../api_clients/abstract_user_access_refresh_token_client.dart';
import 'abstract_refresh_token_repository.dart';
import 'models/refresh_token_dm.dart';

class RefreshTokenRepository implements IRefreshTokenRepository {
  final IUserAccessRefreshTokenClient _userAccessRefreshTokenClient;

  RefreshTokenRepository({
    required IUserAccessRefreshTokenClient userAccessRefreshTokenClient,
  }) : _userAccessRefreshTokenClient = userAccessRefreshTokenClient;

  @override
  AsyncResult<OAuth2Token> refreshToken(RefreshTokenDm refreshTokenDm) async {
    final response = await _userAccessRefreshTokenClient.refreshToken(
      refreshTokenDm.toRm(),
    );
    return response.fold(
      (data) => Success(
        OAuth2Token(
          accessToken: data.accessToken,
          refreshToken: data.refreshToken,
        ),
      ),
      (failure) => Failure(Exception("Error refreshing token: $failure")),
    );
  }
}
