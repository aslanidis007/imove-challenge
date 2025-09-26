import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// Point model for coordinates
class PointDm extends Equatable {
  final double? lat;
  final double? lng;

  const PointDm({required this.lat, required this.lng});

  factory PointDm.fromJson(Map<String, dynamic>? json) {
    return PointDm(lat: (json?['lat'] as num).toDouble(), lng: (json?['lng'] as num).toDouble());
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  @override
  List<Object?> get props => [lat, lng];
}

// Origin/Destination model
class LocationDm extends Equatable {
  final String? formattedAddress;
  final PointDm? point;

  const LocationDm({required this.formattedAddress, required this.point});

  factory LocationDm.fromJson(Map<String, dynamic>? json) {
    return LocationDm(
      formattedAddress: json?['formattedAddress'] as String?,
      point: PointDm.fromJson(json?['point'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() => {'formattedAddress': formattedAddress, 'point': point?.toJson()};

  @override
  List<Object?> get props => [formattedAddress, point];
}

// Service model
class ServiceDm extends Equatable {
  final String id;
  final String name;
  final String description;
  final int maxPassengers;
  final int maxLuggages;

  const ServiceDm({
    required this.id,
    required this.name,
    required this.description,
    required this.maxPassengers,
    required this.maxLuggages,
  });

  factory ServiceDm.fromJson(Map<String, dynamic> json) {
    return ServiceDm(
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
class RidesDm extends Equatable {
  final String id;
  final String type;
  final bool isPreOrder;
  final int status;
  final String? polyline; // Optional since it might not always be present
  final String mapsOverviewUrl;
  final String paymentMethodId;
  final double estimatedDuration;
  final LocationDm origin;
  final LocationDm? destination;
  final ServiceDm service;
  final String actualPickUpDateTime;
  final String actualDropOffDateTime;
  final Uint8List? serviceImageUrl;

  const RidesDm({
    required this.id,
    required this.type,
    required this.isPreOrder,
    required this.status,
    this.polyline,
    this.serviceImageUrl,
    required this.mapsOverviewUrl,
    required this.paymentMethodId,
    required this.estimatedDuration,
    required this.origin,
    this.destination,
    required this.service,
    required this.actualPickUpDateTime,
    required this.actualDropOffDateTime,
  });

  factory RidesDm.fromJson(Map<String, dynamic> json) {
    return RidesDm(
      id: json['id'] as String,
      type: json['type'] as String,
      isPreOrder: json['isPreOrder'] as bool,
      status: json['status'] as int,
      polyline: json['polyline'] as String?,
      mapsOverviewUrl: json['mapsOverviewUrl'] as String,
      paymentMethodId: json['paymentMethodId'] as String,
      estimatedDuration: (json['estimatedDuration'] as num).toDouble(),
      origin: LocationDm.fromJson(json['origin'] as Map<String, dynamic>),
      destination: LocationDm.fromJson(json['destination'] as Map<String, dynamic>),
      service: ServiceDm.fromJson(json['service'] as Map<String, dynamic>),
      actualPickUpDateTime: json['actualPickUpDateTime'] as String,
      actualDropOffDateTime: json['actualDropOffDateTime'] as String,
    );
  }

  copyWith({
    String? id,
    String? type,
    bool? isPreOrder,
    int? status,
    String? polyline,
    String? mapsOverviewUrl,
    String? paymentMethodId,
    double? estimatedDuration,
    LocationDm? origin,
    LocationDm? destination,
    Uint8List? serviceImageUrl,
    ServiceDm? service,
    String? actualPickUpDateTime,
    String? actualDropOffDateTime,
  }) {
    return RidesDm(
      id: id ?? this.id,
      type: type ?? this.type,
      isPreOrder: isPreOrder ?? this.isPreOrder,
      status: status ?? this.status,
      polyline: polyline ?? this.polyline,
      mapsOverviewUrl: mapsOverviewUrl ?? this.mapsOverviewUrl,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      service: service ?? this.service,
      actualPickUpDateTime: actualPickUpDateTime ?? this.actualPickUpDateTime,
      actualDropOffDateTime: actualDropOffDateTime ?? this.actualDropOffDateTime,
      serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
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
    'serviceImageUrl': serviceImageUrl,
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
    serviceImageUrl,
  ];
}

// If your API returns a list of rides, you might also want:
class RidesListResponse extends Equatable {
  final List<RidesDm> items;

  const RidesListResponse({required this.items});

  factory RidesListResponse.fromJson(Map<String, dynamic> json) {
    final items = (json['items'] as List<dynamic>)
        .map((item) => RidesDm.fromJson(item as Map<String, dynamic>))
        .toList();

    return RidesListResponse(items: items);
  }

  Map<String, dynamic> toJson() => {'items': items.map((ride) => ride.toJson()).toList()};

  @override
  List<Object?> get props => [items];
}
