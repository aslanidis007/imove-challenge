import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.secondary,
  scaffoldBackgroundColor: AppColors.pageDefault,
  textTheme: TextTheme(
    titleLarge: TextStyle(color: AppColors.secondary, fontSize: AppThemeConstants.fontTitleLarge),
    titleMedium: TextStyle(color: AppColors.secondary, fontSize: AppThemeConstants.fontTitleMedium),
    titleSmall: TextStyle(color: AppColors.secondary, fontSize: AppThemeConstants.fontTitleSmall),
    bodyMedium: TextStyle(color: AppColors.secondary, fontSize: AppThemeConstants.fontBodyMedium),
    labelMedium: TextStyle(color: AppColors.secondary, fontSize: AppThemeConstants.fontLabelMedium),
  ),
);
