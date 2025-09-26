import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_service_to_dm.dart';

import 'package:imove_challenge/features/rides/api_clients/models/rides_details_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

extension CarRmToDm on CarRm {
  CarDm toDm() => CarDm(
    id: id,
    plateNumber: plateNumber,
    brand: brand,
    model: model,
    color: color,
    year: year,
    service: service.toDm(),
  );
}
