import 'package:get_it/get_it.dart';
import 'package:imove_challenge/features/authentication/api_clients/authentication_url_builder.dart';
import 'package:imove_challenge/features/authentication/api_clients/abstract_authentication_url_builder.dart';

extension AuthenticationUrlBuilderDiExtensions on GetIt {
  GetIt registerAuthenticationUrlBuilder({required String baseUrl, required String apiBasePath}) {
    registerLazySingleton<IAuthenticationUrlBuilder>(
      () => AuthenticationUrlBuilder(baseUrl: baseUrl, apiBasePath: apiBasePath),
    );
    return this;
  }

  IAuthenticationUrlBuilder get authenticationUrlBuilder => get<IAuthenticationUrlBuilder>();
}
