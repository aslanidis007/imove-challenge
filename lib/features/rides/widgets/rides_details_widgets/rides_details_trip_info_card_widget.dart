import 'package:flutter/material.dart';

import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class RidesDetailsTripInfoCardWidget extends StatelessWidget {
  final String? destinationFormattedAddress;
  final String actualPickUpDateTime;
  final String actualDropOffDateTime;
  const RidesDetailsTripInfoCardWidget({
    super.key,
    required this.destinationFormattedAddress,
    required this.actualPickUpDateTime,
    required this.actualDropOffDateTime,
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
            Row(
              children: [
                Icon(Icons.location_on, size: RidesDetailsConstants.locationIconSize),
                SizedBox(width: RidesDetailsConstants.iconTextSpacing),
                if (destinationFormattedAddress != null)
                  Expanded(
                    child: Text(
                      destinationFormattedAddress!,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            ),
            SizedBox(height: RidesDetailsConstants.largeSpacing),
            Row(
              children: [
                Icon(Icons.access_time, size: RidesDetailsConstants.timeIconSize),
                SizedBox(width: RidesDetailsConstants.iconTextSpacing),
                Text(
                  DateTime.parse(actualPickUpDateTime).toString().substring(0, 16),
                  style: appTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
