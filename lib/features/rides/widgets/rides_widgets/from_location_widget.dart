import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class FromLocationWidget extends StatelessWidget {
  final String originFormattedAddress;
  const FromLocationWidget({super.key, required this.originFormattedAddress});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: RideUIConstants.locationDotSize,
          height: RideUIConstants.locationDotSize,
          decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle),
        ),
        SizedBox(width: RideUIConstants.locationDotSpacing),
        Expanded(
          child: Text(
            'From: $originFormattedAddress',
            style: appTheme.textTheme.bodySmall?.copyWith(
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
