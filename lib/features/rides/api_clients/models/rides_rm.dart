import 'package:equatable/equatable.dart';

// Point model for coordinates
class PointRm extends Equatable {
  final double? lat;
  final double? lng;

  const PointRm({required this.lat, required this.lng});

  factory PointRm.fromJson(Map<String, dynamic>? json) {
    return PointRm(
      lat: (json?['lat'] ?? 0 as num).toDouble(),
      lng: (json?['lng'] ?? 0 as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  @override
  List<Object?> get props => [lat, lng];
}

// Origin/Destination model
class LocationRm extends Equatable {
  final String? formattedAddress;
  final PointRm? point;

  const LocationRm({required this.formattedAddress, required this.point});

  factory LocationRm.fromJson(Map<String, dynamic>? json) {
    return LocationRm(
      formattedAddress: json?['formattedAddress'] as String?,
      point: PointRm.fromJson(json?['point'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {'formattedAddress': formattedAddress, 'point': point?.toJson()};

  @override
  List<Object?> get props => [formattedAddress, point];
}

// Service model
class ServiceRm extends Equatable {
  final String id;
  final String name;
  final String description;
  final int maxPassengers;
  final int maxLuggages;

  const ServiceRm({
    required this.id,
    required this.name,
    required this.description,
    required this.maxPassengers,
    required this.maxLuggages,
  });

  factory ServiceRm.fromJson(Map<String, dynamic> json) {
    return ServiceRm(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      maxPassengers: json['maxPassengers'] as int,
      maxLuggages: json['maxLuggages'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'maxPassengers': maxPassengers,
    'maxLuggages': maxLuggages,
  };

  @override
  List<Object?> get props => [id, name, description, maxPassengers, maxLuggages];
}

// Updated main Rides model
class RidesRm extends Equatable {
  final String id;
  final String type;
  final bool isPreOrder;
  final int status;
  final String? polyline; // Optional since it might not always be present
  final String mapsOverviewUrl;
  final String paymentMethodId;
  final double estimatedDuration;
  final LocationRm origin;
  final LocationRm? destination;
  final ServiceRm service;
  final String actualPickUpDateTime;
  final String actualDropOffDateTime;

  const RidesRm({
    required this.id,
    required this.type,
    required this.isPreOrder,
    required this.status,
    this.polyline,
    required this.mapsOverviewUrl,
    required this.paymentMethodId,
    required this.estimatedDuration,
    required this.origin,
    required this.destination,
    required this.service,
    required this.actualPickUpDateTime,
    required this.actualDropOffDateTime,
  });

  factory RidesRm.fromJson(Map<String, dynamic> json) {
    return RidesRm(
      id: json['id'] as String,
      type: json['type'] as String,
      isPreOrder: json['isPreOrder'] as bool,
      status: json['status'] as int,
      polyline: json['polyline'] as String?,
      mapsOverviewUrl: json['mapsOverviewUrl'] as String,
      paymentMethodId: json['paymentMethodId'] as String,
      estimatedDuration: (json['estimatedDuration'] as num).toDouble(),
      origin: LocationRm.fromJson(json['origin'] as Map<String, dynamic>),
      destination: LocationRm.fromJson(json['destination'] as Map<String, dynamic>?),
      service: ServiceRm.fromJson(json['service'] as Map<String, dynamic>),
      actualPickUpDateTime: json['actualPickUpDateTime'] as String,
      actualDropOffDateTime: json['actualDropOffDateTime'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'isPreOrder': isPreOrder,
    'status': status,
    if (polyline != null) 'polyline': polyline,
    'mapsOverviewUrl': mapsOverviewUrl,
    'paymentMethodId': paymentMethodId,
    'estimatedDuration': estimatedDuration,
    'origin': origin.toJson(),
    'destination': destination?.toJson(),
    'service': service.toJson(),
    'actualPickUpDateTime': actualPickUpDateTime,
    'actualDropOffDateTime': actualDropOffDateTime,
  };

  @override
  List<Object?> get props => [
    id,
    type,
    isPreOrder,
    status,
    polyline,
    mapsOverviewUrl,
    paymentMethodId,
    estimatedDuration,
    origin,
    destination,
    service,
    actualPickUpDateTime,
    actualDropOffDateTime,
  ];
}

// If your API returns a list of rides, you might also want:
class RidesListResponse extends Equatable {
  final List<RidesRm> items;

  const RidesListResponse({required this.items});

  factory RidesListResponse.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((item) => RidesRm.fromJson(item as Map<String, dynamic>))
        .toList();

    return RidesListResponse(items: items);
  }

  Map<String, dynamic> toJson() => {'items': items.map((ride) => ride.toJson()).toList()};

  @override
  List<Object?> get props => [items];
}
