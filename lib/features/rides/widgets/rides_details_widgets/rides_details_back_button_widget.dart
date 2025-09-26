import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class RidesDetailsBackButtonWidget extends StatelessWidget {
  const RidesDetailsBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Row(
        children: [
          Icon(Icons.arrow_back, size: RidesDetailsConstants.headerIconSize),
          SizedBox(width: RidesDetailsConstants.headerSpacing),
          Text('Rides Details', style: appTheme.textTheme.titleMedium),
        ],
      ),
    );
  }
}
