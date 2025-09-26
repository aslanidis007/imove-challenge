import 'package:imove_challenge/core/network/user_access_refresh_token/repository/abstract_refresh_token_repository.dart';
import 'package:result_dart/result_dart.dart';

import '../../../services/resilience/abstract_resilient_executor.dart';
import '../../models/auth_token.dart';
import 'models/refresh_token_dm.dart';

class PreResilienceRefreshTokenRepository implements IRefreshTokenRepository {
  final IRefreshTokenRepository _repository;
  final IResilientExecutor _resilientExecutor;

  PreResilienceRefreshTokenRepository({
    required IRefreshTokenRepository repository,
    required IResilientExecutor resilientExecutor,
  }) : _repository = repository,
       _resilientExecutor = resilientExecutor;

  @override
  AsyncResult<OAuth2Token> refreshToken(RefreshTokenDm refreshTokenDm) async {
    final cancelableOperation = _resilientExecutor.execute(
      () => _repository.refreshToken(refreshTokenDm),
    );
    final result = await cancelableOperation.valueOrCancellation();
    if (result?.isError() ?? false) {
      final error = result?.exceptionOrNull();
      if (error != null) {
        return Failure(error);
      }
    }
    return result?.fold((value) => Success(value), (error) => Failure(error)) ??
        Failure(Exception('Failed to refresh token'));
  }
}
