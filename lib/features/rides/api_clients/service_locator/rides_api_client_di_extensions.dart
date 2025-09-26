import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/clients/service_locator/user_access_token_dio_client_di_extensions.dart';
import 'package:imove_challenge/features/rides/api_clients/abstract_rides_api_client.dart';
import 'package:imove_challenge/features/rides/api_clients/rides_api_client.dart';
import 'package:imove_challenge/features/rides/api_clients/service_locator/rides_url_builder_di_extensions.dart';

extension RidesApiClientDiExtensions on GetIt {
  GetIt registerRidesApiClient() {
    registerLazySingleton<IRidesApiClient>(
      () => RidesApiClient(urlBuilder: ridesUrlBuilder, httpClient: userAccessTokenDioClient),
    );
    return this;
  }

  IRidesApiClient get ridesApiClient => get<IRidesApiClient>();
}
