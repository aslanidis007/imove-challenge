import 'package:imove_challenge/features/rides/api_clients/models/rides_details_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

extension DriverRmToDm on DriverRm {
  DriverDm toDm() => DriverDm(
    id: id,
    firstName: firstName,
    lastName: lastName,
    fleetPartnerName: fleetPartnerName,
    phoneNumber: phoneNumber,
    rating: rating,
  );
}
