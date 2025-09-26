class RidesDetailsRm {
  final String? notes;
  final CarRm? car;
  final ClientRm? client;
  final DriverRm? driver;
  final CostRm? tripCost;
  final CostRm? extrasCost;
  final CostRm? discountCost;
  final double? agentOnTopCommissionAmount;
  final CostRm? tipCost;
  final CostRm? paidAmount;
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
  final LocationRm origin;
  final LocationRm destination;
  final ServiceRm service;
  final List<dynamic> stops;
  final String actualPickUpDateTime;
  final String actualDropOffDateTime;

  RidesDetailsRm({
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
  });

  factory RidesDetailsRm.fromJson(Map<String, dynamic> json) {
    return RidesDetailsRm(
      notes: json['notes'],
      car: json['car'] != null ? CarRm.fromJson(json['car']) : null,
      client: json['client'] != null ? ClientRm.fromJson(json['client']) : null,
      driver: json['driver'] != null ? DriverRm.fromJson(json['driver']) : null,
      tripCost: json['tripCost'] != null ? CostRm.fromJson(json['tripCost']) : null,
      extrasCost: json['extrasCost'] != null ? CostRm.fromJson(json['extrasCost']) : null,
      discountCost: json['discountCost'] != null ? CostRm.fromJson(json['discountCost']) : null,
      agentOnTopCommissionAmount: json['agentOnTopCommissionAmount']?.toDouble(),
      tipCost: json['tipCost'] != null ? CostRm.fromJson(json['tipCost']) : null,
      paidAmount: json['paidAmount'] != null ? CostRm.fromJson(json['paidAmount']) : null,
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
      origin: LocationRm.fromJson(json['origin']),
      destination: LocationRm.fromJson(json['destination']),
      service: ServiceRm.fromJson(json['service']),
      stops: json['stops'] ?? [],
      actualPickUpDateTime: json['actualPickUpDateTime'],
      actualDropOffDateTime: json['actualDropOffDateTime'],
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

class CarRm {
  final String id;
  final String plateNumber;
  final String brand;
  final String model;
  final String color;
  final int year;
  final ServiceRm service;

  CarRm({
    required this.id,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.color,
    required this.year,
    required this.service,
  });

  factory CarRm.fromJson(Map<String, dynamic> json) {
    return CarRm(
      id: json['id'],
      plateNumber: json['plateNumber'],
      brand: json['brand'],
      model: json['model'],
      color: json['color'],
      year: json['year'],
      service: ServiceRm.fromJson(json['service']),
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

class ClientRm {
  final String id;
  final String name;
  final String surname;

  ClientRm({required this.id, required this.name, required this.surname});

  factory ClientRm.fromJson(Map<String, dynamic> json) {
    return ClientRm(id: json['id'], name: json['name'], surname: json['surname']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'surname': surname};
  }
}

class DriverRm {
  final String id;
  final String firstName;
  final String lastName;
  final String fleetPartnerName;
  final String phoneNumber;
  final double rating;

  DriverRm({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fleetPartnerName,
    required this.phoneNumber,
    required this.rating,
  });

  factory DriverRm.fromJson(Map<String, dynamic> json) {
    return DriverRm(
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

class CostRm {
  final double amount;
  final String currency;

  CostRm({required this.amount, required this.currency});

  factory CostRm.fromJson(Map<String, dynamic> json) {
    return CostRm(amount: json['amount']?.toDouble() ?? 0.0, currency: json['currency']);
  }

  Map<String, dynamic> toJson() {
    return {'amount': amount, 'currency': currency};
  }
}

class ServiceRm {
  final String id;
  final String name;
  final String description;
  final int maxPassengers;
  final int maxLuggages;

  ServiceRm({
    required this.id,
    required this.name,
    required this.description,
    required this.maxPassengers,
    required this.maxLuggages,
  });

  factory ServiceRm.fromJson(Map<String, dynamic> json) {
    return ServiceRm(
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

class LocationRm {
  final String formattedAddress;
  final PointRm point;

  LocationRm({required this.formattedAddress, required this.point});

  factory LocationRm.fromJson(Map<String, dynamic> json) {
    return LocationRm(
      formattedAddress: json['formattedAddress'] ?? '',
      point: PointRm.fromJson(json['point']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'formattedAddress': formattedAddress, 'point': point.toJson()};
  }
}

class PointRm {
  final double lat;
  final double lng;

  PointRm({required this.lat, required this.lng});

  factory PointRm.fromJson(Map<String, dynamic> json) {
    return PointRm(lat: json['lat']?.toDouble() ?? 0.0, lng: json['lng']?.toDouble() ?? 0.0);
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
