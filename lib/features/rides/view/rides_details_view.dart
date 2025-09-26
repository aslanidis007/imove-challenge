import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';
import 'package:imove_challenge/core/widgets/base_scaffold.dart';
import 'package:imove_challenge/features/rides/bloc/rides_details_bloc/rides_details_bloc.dart';
import 'package:imove_challenge/features/rides/bloc/rides_details_bloc/rides_details_event.dart';
import 'package:imove_challenge/features/rides/bloc/rides_details_bloc/rides_details_state.dart';
import 'package:imove_challenge/features/rides/service_locator/rides_details_bloc_di_extensions.dart';
import 'package:imove_challenge/features/rides/widgets/map_image_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_details_widgets/rides_details_back_button_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_details_widgets/rides_details_driver_and_car_info_card_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_details_widgets/rides_details_notes_widgets.dart';
import 'package:imove_challenge/features/rides/widgets/rides_details_widgets/rides_details_payment_info_card_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_details_widgets/rides_details_service_info_card_widget.dart';
import 'package:imove_challenge/features/rides/widgets/rides_details_widgets/rides_details_trip_info_card_widget.dart';

class RidesDetailsView extends StatefulWidget {
  final String serviceId;
  const RidesDetailsView({super.key, required this.serviceId});

  @override
  State<RidesDetailsView> createState() => _RidesDetailsViewState();
}

class _RidesDetailsViewState extends State<RidesDetailsView> {
  late final RidesDetailsBloc _ridesDetailsBloc;

  final GetIt getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    _ridesDetailsBloc = getIt.ridesDetailsBloc;
    _ridesDetailsBloc.add(GetRidesDetailsEvent(serviceId: widget.serviceId));
  }

  @override
  void dispose() {
    _ridesDetailsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _ridesDetailsBloc,
      child: BaseScaffold(
        bottomSafeArea: false,
        child: BlocBuilder<RidesDetailsBloc, RidesDetailsState>(
          builder: (context, state) {
            if (state is RidesDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is RidesDetailsSuccessState) {
              final rideDetails = state.rideDetails;
              final driver = rideDetails.driver;
              final paidAmount = rideDetails.paidAmount;
              final car = rideDetails.car;

              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: RidesDetailsConstants.pagePadding),
                child: Column(
                  children: [
                    RidesDetailsBackButtonWidget(),
                    SizedBox(height: RidesDetailsConstants.headerBottomMargin),
                    MapImageWidget(mapsOverviewUrl: rideDetails.mapsOverviewUrl),
                    Padding(
                      padding: EdgeInsets.all(RidesDetailsConstants.pagePadding),
                      child: Column(
                        spacing: RidesDetailsConstants.sectionSpacing,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Trip Info Card
                          RidesDetailsTripInfoCardWidget(
                            destinationFormattedAddress: rideDetails.destination.formattedAddress,
                            actualPickUpDateTime: rideDetails.actualPickUpDateTime,
                            actualDropOffDateTime: rideDetails.actualDropOffDateTime,
                          ),

                          // Service Info Card
                          RidesDetailsServiceInfoCardWidget(
                            serviceName: rideDetails.service.name,
                            serviceDescription: rideDetails.service.description,
                            maxPassengers: rideDetails.service.maxPassengers,
                            maxLuggages: rideDetails.service.maxLuggages,
                          ),

                          // Driver & Car Info Card
                          RidesDetailsDriverAndCarInfoCardWidget(
                            driver: driver,
                            car: car,
                            serviceImageUrl: rideDetails.serviceImageUrl,
                          ),

                          // Payment Info Card
                          if (paidAmount != null)
                            RidesDetailsPaymentInfoCardWidget(
                              paidAmount: paidAmount.amount,
                              currency: paidAmount.currency,
                            ),

                          // Notes Card
                          if (rideDetails.notes != null) ...[
                            RidesDetailsNotesWidgets(notes: rideDetails.notes!),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
