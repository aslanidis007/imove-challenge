class RideRoutePaths {
  RideRoutePaths._();

  static const String rides = "/rides";
  static const String rideDetails = "rideDetails/:serviceId";

  static String rideDetailsPath(String serviceId) =>
      "/rides/rideDetails/${Uri.encodeComponent(serviceId)}";
}
