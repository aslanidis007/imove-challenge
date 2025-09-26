import 'package:imove_challenge/features/rides/repositories/extensions/point_to_dm.dart';

import 'package:imove_challenge/features/rides/api_clients/models/rides_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_dm.dart';

extension LocationRmToDm on LocationRm {
  LocationDm toDm() => LocationDm(formattedAddress: formattedAddress, point: point?.toDm());
}
