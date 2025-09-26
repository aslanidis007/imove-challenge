import 'package:imove_challenge/features/rides/api_clients/models/rides_details_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

extension ServiceRmToDm on ServiceRm {
  ServiceDm toDm() => ServiceDm(
    id: id,
    name: name,
    description: description,
    maxPassengers: maxPassengers,
    maxLuggages: maxLuggages,
  );
}
