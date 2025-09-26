import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/network/token_storage/service_locator/user_token_storage_di_extensions.dart';
import 'package:imove_challenge/features/rides/repositories/abstract_rides_repository.dart';

import 'package:imove_challenge/features/rides/bloc/rides_details_bloc/rides_details_bloc.dart';

extension RidesDetailsBlocDiExtensions on GetIt {
  GetIt registerRidesDetailsBloc() {
    registerFactory<RidesDetailsBloc>(
      () => RidesDetailsBloc(
        ridesRepository: get<IRidesRepository>(),
        userAccessTokenStorage: userAccessTokenStorage,
      ),
    );
    return this;
  }

  RidesDetailsBloc get ridesDetailsBloc => get<RidesDetailsBloc>();
}
