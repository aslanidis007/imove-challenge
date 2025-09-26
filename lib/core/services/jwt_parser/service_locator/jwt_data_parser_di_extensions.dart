import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/services/jwt_parser/abstract_jwt_data_parser.dart';
import 'package:imove_challenge/core/services/jwt_parser/jwt_data_parser.dart';

extension JwtDataParserDiExtensions on GetIt {
  GetIt registerJwtDataParser() {
    registerLazySingleton<IJwtDataParser>(() => JwtDataParser());
    return this;
  }

  IJwtDataParser get jwtDataParser => get<IJwtDataParser>();
}
