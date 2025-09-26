import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class RidesDetailsNotesWidgets extends StatelessWidget {
  final String notes;
  const RidesDetailsNotesWidgets({super.key, required this.notes});

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
            Text("Notes", style: appTheme.textTheme.bodyMedium),
            SizedBox(height: RidesDetailsConstants.mediumSpacing),
            Text(notes, style: appTheme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
