import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/config/service_locator/app_config_di_extensions.dart';
import 'package:imove_challenge/core/network/clients/service_locator/core_dio_client_di_extensions.dart';
import 'package:imove_challenge/core/network/clients/service_locator/user_access_token_dio_client_di_extensions.dart';
import 'package:imove_challenge/core/network/token_storage/service_locator/user_token_storage_di_extensions.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/api_clients/service_locator/user_access_refresh_token_builder_di_extensions.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/api_clients/service_locator/user_access_refresh_token_client_di_extensions.dart';
import 'package:imove_challenge/core/network/user_access_refresh_token/service_locator/refresh_token_repository_di_extensions.dart';
import 'package:imove_challenge/core/services/jwt_parser/service_locator/jwt_data_parser_di_extensions.dart';
import 'package:imove_challenge/core/services/refresh_token/user_access_token/service_locator/refresh_user_access_token_service_di_extensions.dart';
import 'package:imove_challenge/core/services/resilience/service_locator/resilience_exectur_di_extensions.dart';
import 'package:imove_challenge/core/services/secure_storage/service_locator/secure_storage_service_di_extensions.dart';
import 'package:imove_challenge/features/authentication/api_clients/service_locator/authentication_api_client_di_extensions.dart';
import 'package:imove_challenge/features/authentication/api_clients/service_locator/authentication_url_builder_di_extensions.dart';
import 'package:imove_challenge/features/authentication/repositories/service_locator/authentication_repository_di_extensions.dart';
import 'package:imove_challenge/features/authentication/service_locator/authentication_bloc_di_extensions.dart';
import 'package:imove_challenge/features/rides/api_clients/service_locator/rides_api_client_di_extensions.dart';
import 'package:imove_challenge/features/rides/api_clients/service_locator/rides_url_builder_di_extensions.dart';
import 'package:imove_challenge/features/rides/repositories/service_locator/rides_repository_di_extensions.dart';
import 'package:imove_challenge/features/rides/service_locator/rides_bloc_di_extensions.dart';
import 'package:imove_challenge/features/rides/service_locator/rides_details_bloc_di_extensions.dart';
import 'package:imove_challenge/router/service_locator/app_router_di_extensions.dart';
import 'package:imove_challenge/router/service_locator/redirect_rule_di_extensions.dart';

Future<GetIt> setupServiceLocator() async {
  final GetIt getIt = GetIt.instance;

  getIt.registerFactory<Dio>(() => Dio());

  getIt.registerLazySingleton(
    () => FlutterSecureStorage(
      // iOS / macOS config:
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.unlocked_this_device,
        accountName: getIt.appConfig.bundleId,
      ),

      // Android config: choose DataStore (new, recommended) or EncryptedSharedPreferences
      aOptions: AndroidOptions(resetOnError: true),
    ),
  );

  getIt.registerAppConfig();
  getIt.registerRedirectRuleServices();
  getIt.registerAppRouter();
  getIt.registerJwtDataParser();
  getIt.registerCoreDioClient(
    httpConnectTimeoutInSeconds: getIt.appConfig.httpConnectTimeoutInSeconds,
    httpReceiveTimeoutInSeconds: getIt.appConfig.httpReceiveTimeoutInSeconds,
  );
  getIt.registerUserAccessTokenDioClient(
    httpConnectTimeoutInSeconds: getIt.appConfig.httpConnectTimeoutInSeconds,
    httpReceiveTimeoutInSeconds: getIt.appConfig.httpReceiveTimeoutInSeconds,
  );
  getIt.registerRefreshTokenRepository();
  getIt.registerUserTokenStorage(keyAccessToken: getIt.appConfig.accessTokenKey);
  getIt.registerAuthenticationUrlBuilder(
    baseUrl: getIt.appConfig.apiBaseUrl,
    apiBasePath: getIt.appConfig.apiBasePath,
  );
  getIt.registerAuthenticationApiClient();
  getIt.registerResilienceExecutor();
  getIt.registerRefreshUserAccessTokenService();
  getIt.registerSecureStorageService();
  getIt.registerAuthenticationRepository();
  getIt.registerUserAccessRefreshTokenBuilder(
    baseUrl: getIt.appConfig.apiBaseUrl,
    apiBasePath: getIt.appConfig.apiBasePath,
  );
  getIt.registerUserAccessRefreshTokenClient();
  getIt.registerRidesUrlBuilder(
    baseUrl: getIt.appConfig.apiBaseUrl,
    apiBasePath: getIt.appConfig.apiBasePath,
  );
  getIt.registerRidesRepository();
  getIt.registerRidesApiClient();

  getIt.registerAuthenticationBloc();
  getIt.registerRidesBloc();
  getIt.registerRidesDetailsBloc();
  return getIt;
}
