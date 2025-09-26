import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class MapImageWidget extends StatelessWidget {
  final String mapsOverviewUrl;
  const MapImageWidget({super.key, required this.mapsOverviewUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      mapsOverviewUrl,
      height: RideUIConstants.mapImageHeight,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: RideUIConstants.mapImageHeight,
          color: AppColors.darkGray,
          child: Center(child: Icon(Icons.map, color: AppColors.secondary.withValues(alpha: 0.5))),
        );
      },
    );
  }
}
