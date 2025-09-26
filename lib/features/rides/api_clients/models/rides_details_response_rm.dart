import 'rides_details_rm.dart';

class RidesDetailsResponseRm {
  final RidesDetailsRm? ridesDetailsData;
  final bool succeeded;
  final RidesDetailsApiErrorRm? error;

  RidesDetailsResponseRm({this.ridesDetailsData, required this.succeeded, this.error});

  factory RidesDetailsResponseRm.fromJson(Map<String, dynamic> json) {
    return RidesDetailsResponseRm(
      ridesDetailsData: json['data'] != null
          ? RidesDetailsRm.fromJson(json['data']['order'])
          : null,
      succeeded: json['succeeded'] ?? false,
      error: json['error'] != null ? RidesDetailsApiErrorRm.fromJson(json['error']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': ridesDetailsData?.toJson(), 'succeeded': succeeded, 'error': error?.toJson()};
  }
}

class RidesDetailsApiErrorRm {
  final int code;
  final String message;
  final List<String> messages;

  RidesDetailsApiErrorRm({required this.code, required this.message, required this.messages});

  factory RidesDetailsApiErrorRm.fromJson(Map<String, dynamic> json) {
    return RidesDetailsApiErrorRm(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      messages: List<String>.from(json['messages'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'message': message, 'messages': messages};
  }
}
