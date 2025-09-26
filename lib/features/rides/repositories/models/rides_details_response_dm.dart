import 'rides_details_dm.dart';

class RidesDetailsResponseDm {
  final RidesDetailsDm? ridesDetailsData;
  final bool succeeded;
  final RidesDetailsApiErrorDm? error;

  RidesDetailsResponseDm({this.ridesDetailsData, required this.succeeded, this.error});

  factory RidesDetailsResponseDm.fromJson(Map<String, dynamic> json) {
    return RidesDetailsResponseDm(
      ridesDetailsData: json['data'] != null ? RidesDetailsDm.fromJson(json['data']) : null,
      succeeded: json['succeeded'] ?? false,
      error: json['error'] != null ? RidesDetailsApiErrorDm.fromJson(json['error']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': ridesDetailsData?.toJson(), 'succeeded': succeeded, 'error': error?.toJson()};
  }
}

class RidesDetailsApiErrorDm {
  final int code;
  final String message;
  final List<String> messages;

  RidesDetailsApiErrorDm({required this.code, required this.message, required this.messages});

  factory RidesDetailsApiErrorDm.fromJson(Map<String, dynamic> json) {
    return RidesDetailsApiErrorDm(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      messages: List<String>.from(json['messages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'messages': messages};
  }
}
