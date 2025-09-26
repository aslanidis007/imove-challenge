import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:imove_challenge/core/network/clients/abstract_user_access_token_http_client.dart';
import 'package:imove_challenge/core/network/extensions/api_response_nullable_extensions.dart';
import 'package:imove_challenge/core/services/debug/log_service.dart';
import 'package:result_dart/result_dart.dart';

import 'abstract_rides_api_client.dart';
import 'exceptions/rides_exceptions.dart';
import 'models/rides_details_response_rm.dart';
import 'models/rides_response_rm.dart';
import 'abstract_rides_url_builder.dart';

class RidesApiClient implements IRidesApiClient {
  final IRidesUrlBuilder _urlBuilder;
  final IUserAccessTokenHttpClient _httpClient;

  RidesApiClient({
    required IRidesUrlBuilder urlBuilder,
    required IUserAccessTokenHttpClient httpClient,
  }) : _urlBuilder = urlBuilder,
       _httpClient = httpClient;

  @override
  AsyncResult<RidesResponseRm> finishedRides(int page) async {
    final result = await _httpClient.get(url: _urlBuilder.finishedRidesUrl(page));
    final response = result.getOrNull();

    return response.isSuccessStatusCode
        ? Success(RidesResponseRm.fromJson(response?.data as Map<String, dynamic>))
        : Failure(result.exceptionOrNull() ?? RidesApiClientException("Something went wrong"));
  }

  @override
  AsyncResult<RidesDetailsResponseRm> rideDetails(String? orderId) async {
    final result = await _httpClient.get(url: _urlBuilder.rideDetailsUrl(orderId));
    final response = result.getOrNull();

    return response.isSuccessStatusCode
        ? Success(RidesDetailsResponseRm.fromJson(response?.data as Map<String, dynamic>))
        : Failure(result.exceptionOrNull() ?? RidesApiClientException("Something went wrong"));
  }

  @override
  AsyncResult<Uint8List> thumbnail(String? serviceId) async {
    final result = await _httpClient.get(
      url: _urlBuilder.thumbnailUrl(serviceId),
      headers: {HttpHeaders.acceptHeader: 'image/png, image/jpeg, image/webp, image/*'},
      responseType: ResponseType.bytes,
    );

    final response = result.getOrNull();
    return response.isSuccessStatusCode
        ? Success(response?.data as Uint8List)
        : Failure(result.exceptionOrNull() ?? RidesApiClientException("Something went wrong"));
  }

  @override
  AsyncResult<Uint8List> driverProfileImage(String? driverId, String? accessToken) async {
    final result = await _httpClient.get(
      url: _urlBuilder.driverProfileImageUrl(driverId, accessToken),
      headers: {HttpHeaders.acceptHeader: 'image/png, image/jpeg, image/webp, image/*'},
      responseType: ResponseType.bytes,
    );
    final response = result.getOrNull();
    return response.isSuccessStatusCode
        ? Success(response?.data as Uint8List)
        : Failure(result.exceptionOrNull() ?? RidesApiClientException("Something went wrong"));
  }
}
