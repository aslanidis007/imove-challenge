import 'package:result_dart/result_dart.dart';

import '../models/auth_token.dart';

abstract class IAccessTokenStorage {
  AsyncResult<Unit> write(OAuth2Token token);
  AsyncResult<Unit> delete();
  AsyncResult<OAuth2Token> read();
}
