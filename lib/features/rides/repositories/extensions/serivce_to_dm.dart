import 'package:imove_challenge/features/rides/api_clients/models/rides_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_dm.dart';

extension SerivceToDm on ServiceRm {
  ServiceDm toDm() => ServiceDm(
    id: id,
    name: name,
    description: description,
    maxPassengers: maxPassengers,
    maxLuggages: maxLuggages,
  );
}
