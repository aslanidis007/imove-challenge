abstract class IRidesUrlBuilder {
  String finishedRidesUrl(int page);
  String thumbnailUrl(String? serviceId);
  String rideDetailsUrl(String? orderId);
  String driverProfileImageUrl(String? driverId, String? accessToken);
}
