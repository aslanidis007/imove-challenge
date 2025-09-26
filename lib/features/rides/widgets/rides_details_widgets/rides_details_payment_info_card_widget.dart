import 'package:flutter/material.dart';

import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class RidesDetailsPaymentInfoCardWidget extends StatelessWidget {
  final double paidAmount;
  final String currency;
  const RidesDetailsPaymentInfoCardWidget({
    super.key,
    required this.paidAmount,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: RidesDetailsConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RidesDetailsConstants.cardBorderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(RidesDetailsConstants.cardPadding),
        child: Row(
          children: [
            Icon(Icons.payment, size: RidesDetailsConstants.paymentIconSize),
            SizedBox(width: RidesDetailsConstants.iconTextSpacing),
            Text("Paid: $paidAmount $currency", style: appTheme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
