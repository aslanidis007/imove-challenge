import 'package:result_dart/result_dart.dart';

import '../../models/auth_token.dart';
import 'models/refresh_token_dm.dart';

abstract class IRefreshTokenRepository {
  AsyncResult<OAuth2Token> refreshToken(RefreshTokenDm refreshTokenDm);
}
