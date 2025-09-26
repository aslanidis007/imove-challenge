import 'package:imove_challenge/features/rides/repositories/extensions/location_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/serivce_to_dm.dart';

import 'package:imove_challenge/features/rides/api_clients/models/rides_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_dm.dart';

extension RidesRmToDm on RidesRm {
  RidesDm toDm() => RidesDm(
    id: id,
    type: type,
    isPreOrder: isPreOrder,
    status: status,
    mapsOverviewUrl: mapsOverviewUrl,
    paymentMethodId: paymentMethodId,
    estimatedDuration: estimatedDuration,
    origin: origin.toDm(),
    destination: destination?.toDm(),
    service: service.toDm(),
    actualPickUpDateTime: actualPickUpDateTime,
    actualDropOffDateTime: actualDropOffDateTime,
  );
}
