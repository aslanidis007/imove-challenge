import 'models/jwt_data.dart';

abstract class IJwtDataParser {
  JWTData parseJwt(String token);
}
