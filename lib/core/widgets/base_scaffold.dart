import 'package:flutter/material.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;
  final bool bottomSafeArea;
  const BaseScaffold({super.key, required this.child, this.bottomSafeArea = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: bottomSafeArea,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppThemeConstants.hPaddingMedium),
          child: child,
        ),
      ),
    );
  }
}
