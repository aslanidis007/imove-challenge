import 'dart:typed_data';

class RidesDetailsDm {
  final String? notes;
  final CarDm? car;
  final ClientDm? client;
  final DriverDm? driver;
  final CostDm? tripCost;
  final CostDm? extrasCost;
  final CostDm? discountCost;
  final double? agentOnTopCommissionAmount;
  final CostDm? tipCost;
  final CostDm? paidAmount;
  final int? driverRating;
  final List<dynamic> orderReports;
  final List<dynamic> serviceExtras;
  final String id;
  final String type;
  final bool isPreOrder;
  final int status;
  final String polyline;
  final String mapsOverviewUrl;
  final String paymentMethodId;
  final double estimatedDuration;
  final LocationDm origin;
  final LocationDm destination;
  final ServiceDm service;
  final List<dynamic> stops;
  final String actualPickUpDateTime;
  final String actualDropOffDateTime;
  final Uint8List? serviceImageUrl;

  RidesDetailsDm({
    this.notes,
    this.car,
    this.client,
    this.driver,
    this.tripCost,
    this.extrasCost,
    this.discountCost,
    this.agentOnTopCommissionAmount,
    this.tipCost,
    this.paidAmount,
    this.driverRating,
    required this.orderReports,
    required this.serviceExtras,
    required this.id,
    required this.type,
    required this.isPreOrder,
    required this.status,
    required this.polyline,
    required this.mapsOverviewUrl,
    required this.paymentMethodId,
    required this.estimatedDuration,
    required this.origin,
    required this.destination,
    required this.service,
    required this.stops,
    required this.actualPickUpDateTime,
    required this.actualDropOffDateTime,
    this.serviceImageUrl,
  });

  factory RidesDetailsDm.fromJson(Map<String, dynamic> json) {
    return RidesDetailsDm(
      notes: json['notes'],
      car: json['car'] != null ? CarDm.fromJson(json['car']) : null,
      client: json['client'] != null ? ClientDm.fromJson(json['client']) : null,
      driver: json['driver'] != null ? DriverDm.fromJson(json['driver']) : null,
      tripCost: json['tripCost'] != null ? CostDm.fromJson(json['tripCost']) : null,
      extrasCost: json['extrasCost'] != null ? CostDm.fromJson(json['extrasCost']) : null,
      discountCost: json['discountCost'] != null ? CostDm.fromJson(json['discountCost']) : null,
      agentOnTopCommissionAmount: json['agentOnTopCommissionAmount']?.toDouble(),
      tipCost: json['tipCost'] != null ? CostDm.fromJson(json['tipCost']) : null,
      paidAmount: json['paidAmount'] != null ? CostDm.fromJson(json['paidAmount']) : null,
      driverRating: json['driverRating'],
      orderReports: json['orderReports'] ?? [],
      serviceExtras: json['serviceExtras'] ?? [],
      id: json['id'],
      type: json['type'],
      isPreOrder: json['isPreOrder'] ?? false,
      status: json['status'],
      polyline: json['polyline'],
      mapsOverviewUrl: json['mapsOverviewUrl'],
      paymentMethodId: json['paymentMethodId'],
      estimatedDuration: json['estimatedDuration']?.toDouble() ?? 0.0,
      origin: LocationDm.fromJson(json['origin']),
      destination: LocationDm.fromJson(json['destination']),
      service: ServiceDm.fromJson(json['service']),
      stops: json['stops'] ?? [],
      actualPickUpDateTime: json['actualPickUpDateTime'],
      actualDropOffDateTime: json['actualDropOffDateTime'],
    );
  }

  RidesDetailsDm copyWith({
    String? notes,
    CarDm? car,
    ClientDm? client,
    DriverDm? driver,
    CostDm? tripCost,
    CostDm? extrasCost,
    CostDm? discountCost,
    double? agentOnTopCommissionAmount,
    CostDm? tipCost,
    CostDm? paidAmount,
    int? driverRating,
    List<dynamic>? orderReports,
    List<dynamic>? serviceExtras,
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
    ServiceDm? service,
    List<dynamic>? stops,
    String? actualPickUpDateTime,
    String? actualDropOffDateTime,
    Uint8List? serviceImageUrl,
  }) {
    return RidesDetailsDm(
      notes: notes ?? this.notes,
      car: car ?? this.car,
      client: client ?? this.client,
      driver: driver ?? this.driver,
      tripCost: tripCost ?? this.tripCost,
      extrasCost: extrasCost ?? this.extrasCost,
      discountCost: discountCost ?? this.discountCost,
      agentOnTopCommissionAmount: agentOnTopCommissionAmount ?? this.agentOnTopCommissionAmount,
      tipCost: tipCost ?? this.tipCost,
      paidAmount: paidAmount ?? this.paidAmount,
      driverRating: driverRating ?? this.driverRating,
      orderReports: orderReports ?? this.orderReports,
      serviceExtras: serviceExtras ?? this.serviceExtras,
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
      stops: stops ?? this.stops,
      actualPickUpDateTime: actualPickUpDateTime ?? this.actualPickUpDateTime,
      actualDropOffDateTime: actualDropOffDateTime ?? this.actualDropOffDateTime,
      serviceImageUrl: serviceImageUrl ?? this.serviceImageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notes': notes,
      'car': car?.toJson(),
      'client': client?.toJson(),
      'driver': driver?.toJson(),
      'tripCost': tripCost?.toJson(),
      'extrasCost': extrasCost?.toJson(),
      'discountCost': discountCost?.toJson(),
      'agentOnTopCommissionAmount': agentOnTopCommissionAmount,
      'tipCost': tipCost?.toJson(),
      'paidAmount': paidAmount?.toJson(),
      'driverRating': driverRating,
      'orderReports': orderReports,
      'serviceExtras': serviceExtras,
      'id': id,
      'type': type,
      'isPreOrder': isPreOrder,
      'status': status,
      'polyline': polyline,
      'mapsOverviewUrl': mapsOverviewUrl,
      'paymentMethodId': paymentMethodId,
      'estimatedDuration': estimatedDuration,
      'origin': origin.toJson(),
      'destination': destination.toJson(),
      'service': service.toJson(),
      'stops': stops,
      'actualPickUpDateTime': actualPickUpDateTime,
      'actualDropOffDateTime': actualDropOffDateTime,
    };
  }
}

class CarDm {
  final String id;
  final String plateNumber;
  final String brand;
  final String model;
  final String color;
  final int year;
  final ServiceDm service;

  CarDm({
    required this.id,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.service,
  });

  factory CarDm.fromJson(Map<String, dynamic> json) {
    return CarDm(
      id: json['id'],
      plateNumber: json['plateNumber'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      year: json['year'],
      service: ServiceDm.fromJson(json['service']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plateNumber': plateNumber,
      'brand': brand,
      'model': model,
      'color': color,
      'year': year,
      'service': service.toJson(),
    };
  }
}

class ClientDm {
  final String id;
  final String name;
  final String surname;

  ClientDm({required this.id, required this.name, required this.surname});

  factory ClientDm.fromJson(Map<String, dynamic> json) {
    return ClientDm(id: json['id'], name: json['name'], surname: json['surname']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'surname': surname};
  }
}

class DriverDm {
  final String id;
  final String firstName;
  final String lastName;
  final String fleetPartnerName;
  final String phoneNumber;
  final double rating;

  DriverDm({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fleetPartnerName,
    required this.phoneNumber,
    required this.rating,
  });

  factory DriverDm.fromJson(Map<String, dynamic> json) {
    return DriverDm(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fleetPartnerName: json['fleetPartnerName'],
      phoneNumber: json['phoneNumber'],
      rating: json['rating']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'fleetPartnerName': fleetPartnerName,
      'phoneNumber': phoneNumber,
      'rating': rating,
    };
  }
}

class CostDm {
  final double amount;
  final String currency;

  CostDm({required this.amount, required this.currency});

  factory CostDm.fromJson(Map<String, dynamic> json) {
    return CostDm(amount: json['amount']?.toDouble() ?? 0.0, currency: json['currency']);
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'currency': currency};
  }
}

class ServiceDm {
  final String id;
  final String name;
  final String description;
  final int maxPassengers;
  final int maxLuggages;

  ServiceDm({
    required this.id,
    required this.name,
    required this.description,
    required this.maxPassengers,
    required this.maxLuggages,
  });

  factory ServiceDm.fromJson(Map<String, dynamic> json) {
    return ServiceDm(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      maxPassengers: json['maxPassengers'],
      maxLuggages: json['maxLuggages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'maxPassengers': maxPassengers,
      'maxLuggages': maxLuggages,
    };
  }
}

class LocationDm {
  final String formattedAddress;
  final PointDm point;

  LocationDm({required this.formattedAddress, required this.point});

  factory LocationDm.fromJson(Map<String, dynamic> json) {
    return LocationDm(
      formattedAddress: json['formattedAddress'] ?? '',
      point: PointDm.fromJson(json['point']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'formattedAddress': formattedAddress, 'point': point.toJson()};
  }
}

class PointDm {
  final double lat;
  final double lng;

  PointDm({required this.lat, required this.lng});

  factory PointDm.fromJson(Map<String, dynamic> json) {
    return PointDm(lat: json['lat']?.toDouble() ?? 0.0, lng: json['lng']?.toDouble() ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
