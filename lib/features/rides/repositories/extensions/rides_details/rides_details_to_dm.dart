import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_car_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_client_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_cost_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_driver_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_location_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_service_to_dm.dart';

import 'package:imove_challenge/features/rides/api_clients/models/rides_details_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

extension RidesDetailsRmToDm on RidesDetailsRm {
  RidesDetailsDm toDm() => RidesDetailsDm(
    notes: notes,
    car: car?.toDm(),
    client: client?.toDm(),
    driver: driver?.toDm(),
    tripCost: tripCost?.toDm(),
    extrasCost: extrasCost?.toDm(),
    discountCost: discountCost?.toDm(),
    agentOnTopCommissionAmount: agentOnTopCommissionAmount,
    tipCost: tipCost?.toDm(),
    paidAmount: paidAmount?.toDm(),
    driverRating: driverRating,
    orderReports: orderReports,
    serviceExtras: serviceExtras,
    id: id,
    type: type,
    isPreOrder: isPreOrder,
    status: status,
    polyline: polyline,
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
