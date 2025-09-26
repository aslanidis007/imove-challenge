import 'package:flutter/cupertino.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class FailureToast extends StatelessWidget {
  const FailureToast({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.error.withValues(),
        borderRadius: BorderRadius.circular(AppThemeConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppThemeConstants.hPaddingMedium,
          vertical: AppThemeConstants.vPaddingMedium,
        ),
        child: Row(
          children: [
            SizedBox(width: AppThemeConstants.hPaddingMedium),
            Expanded(
              child: Text(
                label,
                style: appTheme.textTheme.bodyMedium?.copyWith(color: AppColors.pageDefault),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
