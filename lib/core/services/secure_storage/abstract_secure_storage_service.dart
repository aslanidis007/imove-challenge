import 'package:result_dart/result_dart.dart';

abstract class ISecureStorageService {
  AsyncResult<Unit> deleteAll();
  AsyncResult<Unit> write({required String key, String? value});
  AsyncResult<Unit> delete({required String key});
  AsyncResult<String> read({required String key});
}
