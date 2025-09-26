import 'package:go_router/go_router.dart';
import 'package:imove_challenge/core/constants/empty_string.dart';
import 'package:imove_challenge/features/rides/view/rides_details_view.dart';
import 'package:imove_challenge/features/rides/view/rides_view.dart';
import 'package:imove_challenge/router/constants/router_names/ride_route_names.dart';
import 'package:imove_challenge/router/constants/router_paths/ride_route_names.dart';

class RideRoute {
  GoRoute get rideRoute => GoRoute(
    path: RideRoutePaths.rides,
    name: RideRouteNames.rides,
    builder: (context, state) => const RidesView(),
    routes: [
      GoRoute(
        path: RideRoutePaths.rideDetails,
        name: RideRouteNames.rideDetails,
        builder: (context, state) =>
            RidesDetailsView(serviceId: state.pathParameters['serviceId'] ?? emptyString),
      ),
    ],
  );
}
