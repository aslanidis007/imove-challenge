import 'package:equatable/equatable.dart';

import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

abstract class RidesDetailsState extends Equatable {
  const RidesDetailsState();

  @override
  List<Object?> get props => [];
}

class RidesDetailsInitialState extends RidesDetailsState {}

class RidesDetailsLoadingState extends RidesDetailsState {}

class RidesDetailsSuccessState extends RidesDetailsState {
  final RidesDetailsDm rideDetails;

  const RidesDetailsSuccessState({required this.rideDetails});

  @override
  List<Object?> get props => [rideDetails];
}

class RidesDetailsErrorState extends RidesDetailsState {}
