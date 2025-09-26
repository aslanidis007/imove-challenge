import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_api_error_to_dm.dart';
import 'package:imove_challenge/features/rides/repositories/extensions/rides_details/rides_details_to_dm.dart';

import 'package:imove_challenge/features/rides/repositories/models/rides_details_response_dm.dart';
import 'package:imove_challenge/features/rides/api_clients/models/rides_details_response_rm.dart';

extension RidesDetailsResponseRmToDm on RidesDetailsResponseRm {
  RidesDetailsResponseDm toDm() => RidesDetailsResponseDm(
    ridesDetailsData: ridesDetailsData?.toDm(),
    succeeded: succeeded,
    error: error?.toDm(),
  );
}
