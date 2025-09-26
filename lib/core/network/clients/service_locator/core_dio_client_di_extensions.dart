import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/clients/abstract_core_dio_client.dart';
import 'package:imove_challenge/core/network/clients/core_dio_client.dart';

extension CoreDioClientDiExtensions on GetIt {
  GetIt registerCoreDioClient({
    required int httpConnectTimeoutInSeconds,
    required int httpReceiveTimeoutInSeconds,
  }) {
    registerLazySingleton<ICoreDioClient>(
      () => CoreDioClient(
        httpClient: get<Dio>(),
        httpConnectTimeoutInSeconds: httpConnectTimeoutInSeconds,
        httpReceiveTimeoutInSeconds: httpReceiveTimeoutInSeconds,
      ),
    );
    return this;
  }

  ICoreDioClient get coreDioClient => get<ICoreDioClient>();
}
