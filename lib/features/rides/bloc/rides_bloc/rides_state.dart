import 'dart:collection';

import 'package:equatable/equatable.dart';

import 'package:imove_challenge/features/rides/repositories/models/rides_dm.dart';

abstract class RidesState extends Equatable {
  const RidesState();

  @override
  List<Object?> get props => [];
}

class RidesInitialState extends RidesState {}

class RidesLoadingState extends RidesState {}

class RidesSuccessState extends RidesState {
  final UnmodifiableListView<RidesDm> rides;
  final bool hasMoreData;
  final int currentPage;

  const RidesSuccessState({
    required this.rides,
    required this.hasMoreData,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [rides, hasMoreData, currentPage];
}

class RidesErrorState extends RidesState {}

class RidesLoadMoreErrorState extends RidesState {
  final UnmodifiableListView<RidesDm> rides;
  final bool hasMoreData;

  const RidesLoadMoreErrorState({required this.rides, required this.hasMoreData});

  @override
  List<Object?> get props => [rides, hasMoreData];
}

class RidesLoadingMoreState extends RidesState {
  final UnmodifiableListView<RidesDm> rides;

  const RidesLoadingMoreState({required this.rides});

  @override
  List<Object?> get props => [rides];
}
