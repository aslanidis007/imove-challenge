import '../api_clients/models/refresh_token_rm.dart';
import '../repository/models/refresh_token_dm.dart';

extension RefreshTokenDmToRm on RefreshTokenDm {
  RefreshTokenRm toRm() =>
      RefreshTokenRm(token: token, refreshToken: refreshToken);
}
