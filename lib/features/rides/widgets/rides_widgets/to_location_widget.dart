import 'package:flutter/material.dart';
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
          decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
        ),
        SizedBox(width: RideUIConstants.locationDotSpacing),
        Expanded(
          child: Text(
            'To: $destinationFormattedAddress',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
