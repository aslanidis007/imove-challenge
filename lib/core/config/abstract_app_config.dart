abstract class IAppConfig {
  String get apiBaseUrl;
  String get accessTokenKey;
  int get httpConnectTimeoutInSeconds;
  int get httpReceiveTimeoutInSeconds;
  String get bundleId;
  String get apiBasePath;
}
