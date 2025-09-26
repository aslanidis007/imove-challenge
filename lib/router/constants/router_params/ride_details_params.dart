import 'package:go_router/go_router.dart';
import 'package:imove_challenge/core/constants/empty_string.dart';

class RideDetailsParams {
  final String serviceId;

  RideDetailsParams({required this.serviceId});
}

extension RideDetailsParamsExtension on GoRouterState {
  RideDetailsParams get rideDetailsParams =>
      RideDetailsParams(serviceId: uri.queryParameters['serviceId'] ?? emptyString);
}
