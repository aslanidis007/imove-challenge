import 'dart:collection';

import 'package:imove_challenge/features/rides/repositories/extensions/rides_to_dm.dart';

import 'package:imove_challenge/features/rides/repositories/models/rides_response_dm.dart';
import 'package:imove_challenge/features/rides/api_clients/models/rides_response_rm.dart';

extension RidesResponseRmToDm on RidesResponseRm {
  RidesResponseDm toDm() => RidesResponseDm(
    page: page,
    pageSize: pageSize,
    total: total,
    rides: UnmodifiableListView(rides?.map((ride) => ride.toDm()) ?? []),
  );
}
