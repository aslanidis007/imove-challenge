import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class ToLocationWidget extends StatelessWidget {
  final String destinationFormattedAddress;
  const ToLocationWidget({super.key, required this.destinationFormattedAddress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: RideUIConstants.locationDotSize,
          height: RideUIConstants.locationDotSize,
          decoration: const BoxDecoration(color: AppColors.blue, shape: BoxShape.circle),
        ),
        SizedBox(width: RideUIConstants.locationDotSpacing),
        Expanded(
          child: Text(
            'To: $destinationFormattedAddress',
            style: appTheme.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondary.withValues(alpha: RideUIConstants.secondaryTextOpacity),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
