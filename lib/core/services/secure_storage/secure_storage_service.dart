import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:result_dart/result_dart.dart';

import 'abstract_secure_storage_service.dart';
import 'exception/secure_storage_exception.dart';

class SecureStorageService implements ISecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService(this._storage);

  @override
  AsyncResult<Unit> deleteAll() async {
    try {
      await _storage.deleteAll();
      return const Success(unit);
    } catch (e) {
      return Failure(SecureStorageException(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> write({required String key, String? value}) async {
    try {
      await _storage.write(key: key, value: value);
      return const Success(unit);
    } catch (e) {
      return Failure(SecureStorageException(e.toString()));
    }
  }

  @override
  AsyncResult<Unit> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
      return const Success(unit);
    } catch (e) {
      return Failure(SecureStorageException(e.toString()));
    }
  }

  @override
  AsyncResult<String> read({required String key}) async {
    try {
      final result = await _storage.read(key: key);
      return result != null
          ? Success(result)
          : Failure(SecureStorageException('Storage key not found'));
    } catch (e) {
      return Failure(SecureStorageException(e.toString()));
    }
  }
}
