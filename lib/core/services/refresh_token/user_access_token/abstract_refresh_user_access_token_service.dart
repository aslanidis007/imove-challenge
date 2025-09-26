import 'package:dio/dio.dart';

abstract class IRefreshUserAccessTokenService {
  InterceptorsWrapper createAuthInterceptor();
}
