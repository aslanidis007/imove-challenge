import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class ServiceNameAndStatusWidget extends StatelessWidget {
  final String serviceName;
  final Uint8List? serviceImageUrl;
  final int status;
  const ServiceNameAndStatusWidget({
    super.key,
    required this.serviceName,
    required this.status,
    required this.serviceImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service name and status
        if (serviceImageUrl != null)
          Image.memory(
            serviceImageUrl!,
            height: RideUIConstants.serviceImageHeight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container();
            },
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              serviceName,
              style: appTheme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: RideUIConstants.statusBadgeHorizontalPadding,
                vertical: RideUIConstants.statusBadgeVerticalPadding,
              ),
              decoration: BoxDecoration(
                color: status == 1000
                    ? AppColors.success.withValues(alpha: 0.1)
                    : AppColors.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(RideUIConstants.statusBadgeRadius),
              ),
              child: Text(
                status == 1000 ? 'Completed' : 'Cancelled',
                style: TextStyle(
                  color: status == 1000 ? AppColors.success : AppColors.error,
                  fontSize: RideUIConstants.statusBadgeFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
