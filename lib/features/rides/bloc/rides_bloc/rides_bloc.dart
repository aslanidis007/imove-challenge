import 'dart:collection';

import 'package:imove_challenge/features/rides/repositories/abstract_rides_repository.dart';
import 'package:imove_challenge/features/rides/repositories/models/rides_dm.dart';
import 'rides_event.dart';
import 'rides_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RidesBloc extends Bloc<RidesEvent, RidesState> {
  final IRidesRepository _ridesRepository;
  int _currentPage = 1;
  bool _hasMoreData = true;
  final List<RidesDm> _allRides = [];

  RidesBloc({required IRidesRepository ridesRepository})
    : _ridesRepository = ridesRepository,
      super(RidesInitialState()) {
    on<GetRidesEvent>(_onGetRides);
    on<LoadMoreRidesEvent>(_onLoadMoreRides);
  }

  Future<void> _onGetRides(GetRidesEvent event, Emitter<RidesState> emit) async {
    emit(RidesLoadingState());

    // Reset pagination state for fresh load
    _currentPage = 1;
    _hasMoreData = true;
    _allRides.clear();

    await _fetchRidesPage(emit, isLoadMore: false);
  }

  Future<void> _onLoadMoreRides(LoadMoreRidesEvent event, Emitter<RidesState> emit) async {
    // Don't load more if we don't have more data or already loading
    if (!_hasMoreData || state is RidesLoadingMoreState) return;

    emit(RidesLoadingMoreState(rides: UnmodifiableListView(_allRides)));

    _currentPage++;
    await _fetchRidesPage(emit, isLoadMore: true);
  }

  Future<void> _fetchRidesPage(Emitter<RidesState> emit, {required bool isLoadMore}) async {
    final result = await _ridesRepository.finishedRides(_currentPage);

    await result.fold(
      (data) async {
        // Check if we have more data to load
        _hasMoreData =
            data.rides != null &&
            data.rides!.length == data.pageSize &&
            (_currentPage * data.pageSize) < data.total;

        // Process images for new rides
        List<RidesDm> ridesWithImages = [];
        for (var ride in data.rides ?? []) {
          final image = await _ridesRepository.thumbnailUrl(ride.service.id);
          final imageUrl = image.getOrNull();
          ridesWithImages.add(ride.copyWith(serviceImageUrl: imageUrl));
        }

        // Add new rides to our collection
        _allRides.addAll(ridesWithImages);

        emit(
          RidesSuccessState(
            rides: UnmodifiableListView(_allRides),
            hasMoreData: _hasMoreData,
            currentPage: _currentPage,
          ),
        );
      },
      (error) {
        if (isLoadMore) {
          // If load more failed, revert page number and emit error with current data
          _currentPage--;
          emit(
            RidesLoadMoreErrorState(
              rides: UnmodifiableListView(_allRides),
              hasMoreData: _hasMoreData,
            ),
          );
        } else {
          emit(RidesErrorState());
        }
      },
    );
  }

  // Helper getter to check if we can load more
  bool get canLoadMore => _hasMoreData && state is! RidesLoadingMoreState;
}
