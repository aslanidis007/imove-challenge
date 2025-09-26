import 'package:imove_challenge/core/network/user_access_refresh_token/api_clients/abstract_user_access_refresh_token_builder.dart';

class UserAccessRefreshTokenBuilder implements IUserAccessRefreshTokenBuilder {
  final String _baseUrl;
  final String _apiBasePath;

  UserAccessRefreshTokenBuilder({required String baseUrl, required String apiBasePath})
    : _baseUrl = baseUrl,
      _apiBasePath = apiBasePath;

  @override
  String get refreshTokenUrl => '$_baseUrl/$_apiBasePath/v1/Auth/RefreshToken';
}
