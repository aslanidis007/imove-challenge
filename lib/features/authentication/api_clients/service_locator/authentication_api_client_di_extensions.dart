import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/clients/service_locator/core_dio_client_di_extensions.dart';
import 'package:imove_challenge/features/authentication/api_clients/authentication_api_client.dart';
import 'package:imove_challenge/features/authentication/api_clients/abstract_authentication_api_client.dart';
import 'package:imove_challenge/features/authentication/api_clients/service_locator/authentication_url_builder_di_extensions.dart';

extension AuthenticationUrlBuilderDiExtensions on GetIt {
  GetIt registerAuthenticationApiClient() {
    registerLazySingleton<IAuthenticationApiClient>(
      () => AuthenticationApiClient(
        urlBuilder: authenticationUrlBuilder,
        httpClient: coreDioClient,
      ),
    );
    return this;
  }

  IAuthenticationApiClient get authenticationApiClient =>
      get<IAuthenticationApiClient>();
}
