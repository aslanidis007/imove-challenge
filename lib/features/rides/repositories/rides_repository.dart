import 'dart:typed_data';

import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_response_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_response_to_dm.dart';
import 'package:result_dart/result_dart.dart';

import 'package:imove_challenge/features/rides/api_clients/abstract_rides_api_client.dart';
import 'abstract_rides_repository.dart';
import 'models/rides_details_response_dm.dart';
import 'models/rides_response_dm.dart';

class RidesRepository implements IRidesRepository {
  final IRidesApiClient _apiClient;

  RidesRepository({required IRidesApiClient apiClient}) : _apiClient = apiClient;
  @override
  AsyncResult<RidesResponseDm> finishedRides(int page) async {
    final response = await _apiClient.finishedRides(page);
    return response.fold((data) async {
      return Success(data.toDm());
    }, (error) => Failure(error));
  }

  @override
  AsyncResult<RidesDetailsResponseDm> rideDetails(String orderId) async {
    final response = await _apiClient.rideDetails(orderId);
    return response.fold((data) async {
      return Success(data.toDm());
    }, (error) => Failure(error));
  }

  @override
  AsyncResult<Uint8List> thumbnailUrl(String serviceId) async {
    final response = await _apiClient.thumbnail(serviceId);
    return response.fold((data) async {
      return Success(data);
    }, (error) => Failure(error));
  }

  @override
  AsyncResult<Uint8List> driverProfileImageUrl(String driverId, String accessToken) async {
    final response = await _apiClient.driverProfileImage(driverId, accessToken);
    return response.fold((data) async {
      return Success(data);
    }, (error) => Failure(error));
  }
}
