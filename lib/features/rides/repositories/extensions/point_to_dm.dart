import 'package:imove_challenge/features/rides/api_clients/models/rides_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_dm.dart';

extension PointRmToDm on PointRm {
  PointDm toDm() => PointDm(lat: lat, lng: lng);
}
