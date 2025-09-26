import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../abstract_secure_storage_service.dart';
import '../secure_storage_service.dart';

extension SecureStorageServiceDiExtensions on GetIt {
  GetIt registerSecureStorageService() {
    registerLazySingleton<ISecureStorageService>(
      () => SecureStorageService(get<FlutterSecureStorage>()),
    );
    return this;
  }

  GetIt resetSecureStorageService() {
    resetLazySingleton<ISecureStorageService>();
    return this;
  }

  ISecureStorageService get secureStorageService =>
      get<ISecureStorageService>();
}
