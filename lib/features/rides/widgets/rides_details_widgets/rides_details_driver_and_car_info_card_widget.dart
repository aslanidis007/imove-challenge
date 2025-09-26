import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

import 'package:imove_challenge/features/rides/repositories/models/rides_details_dm.dart';

class RidesDetailsDriverAndCarInfoCardWidget extends StatelessWidget {
  final DriverDm? driver;
  final CarDm? car;
  final Uint8List? serviceImageUrl;

  const RidesDetailsDriverAndCarInfoCardWidget({
    super.key,
    required this.driver,
    required this.car,
    required this.serviceImageUrl,
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
            if (driver != null) ...[
              Row(
                children: [
                  CircleAvatar(
                    radius: RidesDetailsConstants.avatarRadius,
                    backgroundColor: AppColors.darkGray,
                    child: serviceImageUrl != null
                        ? ClipOval(
                            child: Image.memory(
                              serviceImageUrl!,
                              width: RidesDetailsConstants.avatarImageSize,
                              height: RidesDetailsConstants.avatarImageSize,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.person),
                  ),
                  SizedBox(width: RidesDetailsConstants.largeSpacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${driver!.firstName} ${driver!.lastName}",
                          style: appTheme.textTheme.bodyMedium,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: AppColors.secondary,
                              size: RidesDetailsConstants.starIconSize,
                            ),
                            SizedBox(width: RidesDetailsConstants.smallSpacing),
                            Text(driver!.rating.toString(), style: appTheme.textTheme.bodyMedium),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (car != null) SizedBox(height: RidesDetailsConstants.largeSpacing),
            ],
            if (car != null)
              Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    color: AppColors.secondary,
                    size: RidesDetailsConstants.carIconSize,
                  ),
                  SizedBox(width: RidesDetailsConstants.iconTextSpacing),
                  Text(car!.plateNumber, style: appTheme.textTheme.bodyMedium),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
