import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class DateAndDurationWidget extends StatelessWidget {
  final String actualPickUpDateTime;
  final double estimatedDuration;
  const DateAndDurationWidget({
    super.key,
    required this.actualPickUpDateTime,
    required this.estimatedDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: RideUIConstants.smallIconSize,
              color: AppColors.secondary.withValues(alpha: RideUIConstants.tertiaryTextOpacity),
            ),
            SizedBox(width: RideUIConstants.iconTextSpacing),
            Text(
              DateTime.parse(actualPickUpDateTime).toString().substring(0, 16),
              style: appTheme.textTheme.bodySmall?.copyWith(
                color: AppColors.secondary.withValues(alpha: RideUIConstants.tertiaryTextOpacity),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(
              Icons.timer_outlined,
              size: RideUIConstants.smallIconSize,
              color: AppColors.secondary.withValues(alpha: RideUIConstants.tertiaryTextOpacity),
            ),
            SizedBox(width: RideUIConstants.iconTextSpacing),
            Text(
              '${(estimatedDuration / 60).toStringAsFixed(0)} min',
              style: appTheme.textTheme.bodySmall?.copyWith(
                color: AppColors.secondary.withValues(alpha: RideUIConstants.tertiaryTextOpacity),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
