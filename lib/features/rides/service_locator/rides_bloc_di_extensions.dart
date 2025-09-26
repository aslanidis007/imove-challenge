import 'package:get_it/get_it.dart';
import 'package:imove_challenge/features/rides/repositories/abstract_rides_repository.dart';

import 'package:imove_challenge/features/rides/bloc/rides_bloc/rides_bloc.dart';

extension RidesBlocDiExtensions on GetIt {
  GetIt registerRidesBloc() {
    registerLazySingleton<RidesBloc>(() => RidesBloc(ridesRepository: get<IRidesRepository>()));
    return this;
  }

  RidesBloc get ridesBloc => get<RidesBloc>();
}
