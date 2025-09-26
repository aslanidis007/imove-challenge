import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/features/rides/service_locator/rides_bloc_di_extensions.dart';
import 'package:imove_challenge/router/constants/router_paths/ride_route_names.dart';

import 'package:imove_challenge/core/widgets/base_scaffold.dart';
import 'package:imove_challenge/features/rides/bloc/rides_bloc/rides_bloc.dart';
import 'package:imove_challenge/features/rides/bloc/rides_bloc/rides_state.dart';
import 'package:imove_challenge/features/rides/bloc/rides_bloc/rides_event.dart';
import 'package:imove_challenge/features/rides/widgets/rides_widgets/date_and_duration_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_widgets/from_location_widget.dart';
import 'package:imove_challenge/features/rides/widgets/map_image_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_widgets/service_name_and_status_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_widgets/to_location_widget.dart';

class RidesView extends StatefulWidget {
  const RidesView({super.key});

  @override
  State<RidesView> createState() => _RidesViewState();
}

class _RidesViewState extends State<RidesView> {
  late final RidesBloc _ridesBloc;
  final GetIt getIt = GetIt.instance;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _ridesBloc = getIt.ridesBloc;
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      // Trigger load more when user scrolls to 300px from bottom
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 300) {
        if (_ridesBloc.canLoadMore) {
          _ridesBloc.add(LoadMoreRidesEvent());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ridesBloc..add(GetRidesEvent()),
      child: BaseScaffold(
        bottomSafeArea: false,
        child: SizedBox(
          width: 1.sw,
          height: 1.sh,
          child: BlocBuilder<RidesBloc, RidesState>(
            builder: (context, state) {
              // Handle all states that contain rides data
              if (state is RidesSuccessState || state is RidesLoadingMoreState) {
                final rides = state is RidesSuccessState
                    ? state.rides
                    : (state as RidesLoadingMoreState).rides;
                final hasMoreData = state is RidesSuccessState ? state.hasMoreData : true;
                final isLoadingMore = state is RidesLoadingMoreState;

                return ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.all(RideUIConstants.listViewPadding),
                  itemCount: rides.length + (hasMoreData ? 1 : 0),
                  itemBuilder: (context, index) {
                    // Show loading indicator at the end when loading more
                    if (index == rides.length && isLoadingMore) {
                      return Container(
                        padding: EdgeInsets.all(RideUIConstants.cardPadding),
                        child: const Center(
                          child: CircularProgressIndicator(color: AppColors.secondary),
                        ),
                      );
                    }

                    // Skip the extra item if not loading more
                    if (index == rides.length) {
                      return const SizedBox.shrink();
                    }

                    final ride = rides[index];
                    return GestureDetector(
                      onTap: () {
                        context.push(RideRoutePaths.rideDetailsPath(ride.id));
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: RideUIConstants.cardMarginBottom),
                        decoration: BoxDecoration(
                          color: AppColors.pageDefault,
                          borderRadius: BorderRadius.circular(RideUIConstants.cardBorderRadius),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withValues(
                                alpha: RideUIConstants.cardShadowOpacity,
                              ),
                              blurRadius: RideUIConstants.cardShadowBlurRadius,
                              offset: RideUIConstants.cardShadowOffset,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Map image
                            MapImageWidget(mapsOverviewUrl: ride.mapsOverviewUrl),

                            // Content
                            Padding(
                              padding: EdgeInsets.all(RideUIConstants.cardPadding),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Service name and status
                                  ServiceNameAndStatusWidget(
                                    serviceName: ride.service.name,
                                    status: ride.status,
                                    serviceImageUrl: ride.serviceImageUrl,
                                  ),

                                  SizedBox(height: RideUIConstants.sectionSpacing),

                                  // From location
                                  if (ride.origin.formattedAddress != null)
                                    FromLocationWidget(
                                      originFormattedAddress: ride.origin.formattedAddress!,
                                    ),

                                  SizedBox(height: RideUIConstants.locationSpacing),

                                  // To location
                                  if (ride.destination?.formattedAddress != null)
                                    ToLocationWidget(
                                      destinationFormattedAddress:
                                          ride.destination!.formattedAddress!,
                                    ),

                                  SizedBox(height: RideUIConstants.sectionSpacing),

                                  // Date and duration
                                  DateAndDurationWidget(
                                    actualPickUpDateTime: ride.actualPickUpDateTime,
                                    estimatedDuration: ride.estimatedDuration,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }

              if (state is RidesLoadingState) {
                return const Center(child: CircularProgressIndicator(color: AppColors.secondary));
              }
              if (state is RidesErrorState) {
                return Center(
                  child: Text(
                    'Something went wrong, please try again later',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
