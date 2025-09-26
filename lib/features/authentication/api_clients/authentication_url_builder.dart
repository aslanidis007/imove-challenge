import 'abstract_authentication_url_builder.dart';

class AuthenticationUrlBuilder implements IAuthenticationUrlBuilder {
  final String _baseUrl;
  final String _apiBasePath;

  AuthenticationUrlBuilder({required String baseUrl, required String apiBasePath})
    : _baseUrl = baseUrl,
      _apiBasePath = apiBasePath;

  @override
  String get verifyUrl => '$_baseUrl/$_apiBasePath/v1/auth/verify';

  @override
  String get authenticateUrl => '$_baseUrl/$_apiBasePath/v1/auth/authenticate';
}
