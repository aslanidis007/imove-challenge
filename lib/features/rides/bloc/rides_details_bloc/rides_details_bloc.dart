import 'dart:typed_data';

import 'package:imove_challenge/core/network/token_storage/abstract_user_access_token_storage.dart';
import 'package:imove_challenge/features/rides/repositories/abstract_rides_repository.dart';
import 'rides_details_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'rides_details_state.dart';

class RidesDetailsBloc extends Bloc<RidesDetailsEvent, RidesDetailsState> {
  final IRidesRepository _ridesRepository;
  final IUserAccessTokenStorage _userAccessTokenStorage;

  RidesDetailsBloc({
    required IRidesRepository ridesRepository,
    required IUserAccessTokenStorage userAccessTokenStorage,
  }) : _ridesRepository = ridesRepository,
       _userAccessTokenStorage = userAccessTokenStorage,
       super(RidesDetailsInitialState()) {
    on<GetRidesDetailsEvent>(_onGetRidesDetails);
  }

  Future<void> _onGetRidesDetails(
    GetRidesDetailsEvent event,
    Emitter<RidesDetailsState> emit,
  ) async {
    emit(RidesDetailsLoadingState());
    final result = await _ridesRepository.rideDetails(event.serviceId);

    await result.fold(
      (data) async {
        final accessToken = await _userAccessTokenStorage.read();
        Uint8List? imageUrl;

        if (data.ridesDetailsData?.driver?.id != null &&
            accessToken.getOrNull()?.accessToken != null) {
          final image = await _ridesRepository.driverProfileImageUrl(
            data.ridesDetailsData!.driver!.id,
            accessToken.getOrNull()!.accessToken,
          );
          imageUrl = image.getOrNull();
        }

        emit(
          RidesDetailsSuccessState(
            rideDetails: data.ridesDetailsData!.copyWith(serviceImageUrl: imageUrl),
          ),
        );
      },
      (error) {
        emit(RidesDetailsErrorState());
      },
    );
  }
}
