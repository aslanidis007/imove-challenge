import 'package:result_dart/result_dart.dart';

import 'package:imove_challenge/core/exceptions/result_no_data_exception.dart';
import 'package:imove_challenge/core/services/resilience/abstract_resilient_executor.dart';
import 'package:imove_challenge/features/authentication/repositories/abstract_authentication_repository.dart';
import 'models/authentication_dm.dart';
import 'models/authentication_response_dm.dart';
import 'models/verification_dm.dart';
import 'models/verification_response_dm.dart';

class PreResilienceAuthenticationRepository implements IAuthenticationRepository {
  final IResilientExecutor _resilientExecutor;
  final IAuthenticationRepository _repository;

  PreResilienceAuthenticationRepository({
    required IAuthenticationRepository repository,
    required IResilientExecutor resilientExecutor,
  }) : _repository = repository,
       _resilientExecutor = resilientExecutor;

  @override
  AsyncResult<AuthenticationResponseDm> authenticate(AuthenticationDm authenticationDm) async {
    final cancelableOperation = _resilientExecutor.execute(
      () => _repository.authenticate(authenticationDm),
    );
    final result = await cancelableOperation.valueOrCancellation();
    if (result?.isError() ?? false) {
      final error = result?.exceptionOrNull();
      if (error != null) {
        return Failure(error);
      }
    }
    return result?.fold((value) => Success(value), (error) => Failure(error)) ??
        const Failure(ResultNoDataException());
  }

  @override
  AsyncResult<VerificationResponseDm> verifyPhoneNumber(VerificationDm verificationDm) async {
    final cancelableOperation = _resilientExecutor.execute(
      () => _repository.verifyPhoneNumber(verificationDm),
    );
    final result = await cancelableOperation.valueOrCancellation();
    if (result?.isError() ?? false) {
      final error = result?.exceptionOrNull();
      if (error != null) {
        return Failure(error);
      }
    }
    return result?.fold((value) => Success(value), (error) => Failure(error)) ??
        const Failure(ResultNoDataException());
  }
}
