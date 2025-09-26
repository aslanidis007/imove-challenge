import 'dart:typed_data';

import 'package:result_dart/result_dart.dart';

import 'models/rides_details_response_rm.dart';
import 'models/rides_response_rm.dart';

abstract class IRidesApiClient {
  AsyncResult<RidesResponseRm> finishedRides(int page);

  AsyncResult<RidesDetailsResponseRm> rideDetails(String? orderId);

  AsyncResult<Uint8List> thumbnail(String? serviceId);

  AsyncResult<Uint8List> driverProfileImage(String? driverId, String? accessToken);
}
