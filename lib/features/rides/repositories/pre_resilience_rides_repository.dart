import 'dart:typed_data';

import 'package:result_dart/result_dart.dart';

import 'package:imove_challenge/core/exceptions/result_no_data_exception.dart';
import 'package:imove_challenge/core/services/resilience/abstract_resilient_executor.dart';
import 'abstract_rides_repository.dart';
import 'models/rides_response_dm.dart';
import 'models/rides_details_response_dm.dart';

class PreResilienceRidesRepository implements IRidesRepository {
  final IResilientExecutor _resilientExecutor;
  final IRidesRepository _repository;

  PreResilienceRidesRepository({
    required IRidesRepository repository,
    required IResilientExecutor resilientExecutor,
  }) : _repository = repository,
       _resilientExecutor = resilientExecutor;

  @override
  AsyncResult<RidesResponseDm> finishedRides(int page) async {
    final cancelableOperation = _resilientExecutor.execute(() => _repository.finishedRides(page));
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
  AsyncResult<RidesDetailsResponseDm> rideDetails(String orderId) async {
    final cancelableOperation = _resilientExecutor.execute(() => _repository.rideDetails(orderId));
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
  AsyncResult<Uint8List> thumbnailUrl(String serviceId) async {
    final cancelableOperation = _resilientExecutor.execute(
      () => _repository.thumbnailUrl(serviceId),
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
  AsyncResult<Uint8List> driverProfileImageUrl(String driverId, String accessToken) async {
    final cancelableOperation = _resilientExecutor.execute(
      () => _repository.driverProfileImageUrl(driverId, accessToken),
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
