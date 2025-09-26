import 'dart:typed_data';

import 'package:result_dart/result_dart.dart';

import 'models/rides_response_dm.dart';
import 'models/rides_details_response_dm.dart';

abstract class IRidesRepository {
  AsyncResult<RidesResponseDm> finishedRides(int page);

  AsyncResult<RidesDetailsResponseDm> rideDetails(String orderId);

  AsyncResult<Uint8List> thumbnailUrl(String serviceId);

  AsyncResult<Uint8List> driverProfileImageUrl(String driverId, String accessToken);
}
