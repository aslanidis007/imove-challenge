import 'package:result_dart/result_dart.dart';

import '../../models/auth_token.dart';
import 'models/refresh_token_rm.dart';

abstract class IUserAccessRefreshTokenClient {
  AsyncResult<OAuth2Token> refreshToken(RefreshTokenRm refreshTokenRm);
}
