import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class RidesDetailsServiceInfoCardWidget extends StatelessWidget {
  final String serviceName;
  final String serviceDescription;
  final int maxPassengers;
  final int maxLuggages;
  const RidesDetailsServiceInfoCardWidget({
    super.key,
    required this.serviceName,
    required this.serviceDescription,
    required this.maxPassengers,
    required this.maxLuggages,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: RidesDetailsConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RidesDetailsConstants.cardBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(RidesDetailsConstants.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(serviceName, style: appTheme.textTheme.titleMedium),
            SizedBox(height: RidesDetailsConstants.mediumSpacing),
            Text(serviceDescription, style: appTheme.textTheme.bodyMedium),
            SizedBox(height: RidesDetailsConstants.largeSpacing),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: RidesDetailsConstants.chipHorizontalPadding,
                    vertical: RidesDetailsConstants.chipVerticalPadding,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(RidesDetailsConstants.chipBorderRadius),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.people,
                        size: RidesDetailsConstants.peopleIconSize,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: RidesDetailsConstants.smallSpacing),
                      Text('$maxPassengers passengers', style: appTheme.textTheme.bodyMedium),
                    ],
                  ),
                ),
                SizedBox(width: RidesDetailsConstants.chipSpacing),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: RidesDetailsConstants.chipHorizontalPadding,
                    vertical: RidesDetailsConstants.chipVerticalPadding,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(RidesDetailsConstants.chipBorderRadius),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.luggage,
                        size: RidesDetailsConstants.luggageIconSize,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: RidesDetailsConstants.smallSpacing),
                      Text('$maxLuggages luggage', style: appTheme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
