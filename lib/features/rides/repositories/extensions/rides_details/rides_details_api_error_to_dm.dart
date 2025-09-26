import 'package:imove_challenge/features/rides/repositories/models/rides_details_response_dm.dart';
import 'package:imove_challenge/features/rides/api_clients/models/rides_details_response_rm.dart';

extension RidesDetailsApiErrorRmToDm on RidesDetailsApiErrorRm {
  RidesDetailsApiErrorDm toDm() =>
      RidesDetailsApiErrorDm(code: code, message: message, messages: messages);
}
