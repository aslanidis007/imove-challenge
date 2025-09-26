import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_point_to_dm.dart';

import 'package:imove_challenge/features/rides/api_clients/models/rides_details_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

extension LocationRmToDm on LocationRm {
  LocationDm toDm() => LocationDm(formattedAddress: formattedAddress, point: point.toDm());
}
