import 'package:get_it/get_it.dart';
import 'package:imove_challenge/features/rides/api_clients/abstract_rides_url_builder.dart';
import 'package:imove_challenge/features/rides/api_clients/rides_url_builder.dart';

extension RidesUrlBuilderDiExtensions on GetIt {
  GetIt registerRidesUrlBuilder({required String baseUrl, required String apiBasePath}) {
    registerLazySingleton<IRidesUrlBuilder>(
      () => RidesUrlBuilder(baseUrl: baseUrl, apiBasePath: apiBasePath),
    );
    return this;
  }

  IRidesUrlBuilder get ridesUrlBuilder => get<IRidesUrlBuilder>();
}
