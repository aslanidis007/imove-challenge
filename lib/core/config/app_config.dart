import 'abstract_app_config.dart';

class AppConfig implements IAppConfig {
  @override
  String get apiBaseUrl => 'https://imove-api-dev.azurewebsites.net';

  @override
  String get apiBasePath => 'api';

  @override
  String get accessTokenKey => 'access_token';

  @override
  int get httpConnectTimeoutInSeconds => 10;

  @override
  int get httpReceiveTimeoutInSeconds => 10;

  @override
  String get bundleId => 'com.imove.app';
}
