import 'package:result_dart/result_dart.dart';

import 'abstract_access_token_storage.dart';

abstract class IUserAccessTokenStorage implements IAccessTokenStorage {
  AsyncResult<Unit> isLoggedIn();
}
