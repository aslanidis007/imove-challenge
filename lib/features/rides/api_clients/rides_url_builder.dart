import 'package:imove_challenge/core/utils/extensions/string_extensions.dart';

import 'abstract_rides_url_builder.dart';

class RidesUrlBuilder implements IRidesUrlBuilder {
  final String _baseUrl;
  final String _apiBasePath;

  RidesUrlBuilder({required String baseUrl, required String apiBasePath})
    : _baseUrl = baseUrl,
      _apiBasePath = apiBasePath;

  @override
  String finishedRidesUrl(int page) => '$_baseUrl/$_apiBasePath/v1/order/finished/paging'.buildUrl(
    queryParameters: {'page': page.toString()},
  );

  @override
  String thumbnailUrl(String? serviceId) =>
      '$_baseUrl/$_apiBasePath/v1/Document/Thumbnail/Download'.buildUrl(
        queryParameters: {'owner': 'service', 'type': 'serviceImage', 'ownerId': serviceId},
      );

  @override
  String rideDetailsUrl(String? orderId) => '$_baseUrl/$_apiBasePath/v1/order/finished/$orderId';

  @override
  String driverProfileImageUrl(String? driverId, String? accessToken) =>
      '$_baseUrl/$_apiBasePath/v1/Document/Thumbnail/Download'.buildUrl(
        queryParameters: {
          'owner': 'driver',
          'type': 'driverProfileImage',
          'ownerId': driverId,
          'access_token': accessToken,
        },
      );
}
