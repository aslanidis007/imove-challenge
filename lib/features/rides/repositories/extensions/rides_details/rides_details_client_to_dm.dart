import 'package:imove_challenge/features/rides/api_clients/models/rides_details_rm.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

extension ClientRmToDm on ClientRm {
  ClientDm toDm() => ClientDm(id: id, name: name, surname: surname);
}
