import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemeConstants {
  AppThemeConstants._();
  static Size screenSize(BuildContext context) => MediaQuery.sizeOf(context);
  static EdgeInsets padding(BuildContext context) => MediaQuery.paddingOf(context);

  static double fontTitleLarge = 24.0.sp;
  static double fontTitleMedium = 18.0.sp;
  static double fontTitleSmall = 16.0.sp;
  static double fontBodyMedium = 14.0.sp;
  static double fontLabelMedium = 12.0.sp;

  static double vPaddingMedium = 16.0.h;
  static double vPaddingLarge = 24.0.h;
  static double vPaddingXLarge = 32.0.h;
  static double vPaddingSmall = 8.0.h;

  static double hPaddingMedium = 16.0.w;
  static double hPaddingLarge = 24.0.w;

  static double borderRadiusLarge = 24.0.r;

  static double heightMedium = 16.0.h;
}

class ToastConstants {
  ToastConstants._();
  static double toastMargin = 16.0.w;
  static double toastHeight = 48.0.h;
  static double toastWidth = 343.0.w;
  static double toastBorderRadius = 24.0.r;
  static double toastBackgroundOpacity = 0.8;
  static double heightLarge = 60.0.h;

  static int milliseconds3000 = 3000;
  static int milliseconds500 = 500;
  static int milliseconds300 = 300;
}

class OtpCodeConstants {
  OtpCodeConstants._();
  static double pinputHeight = 40.0.h;
  static double pinputBorderRadius = 14.0.r;
}

class RideUIConstants {
  RideUIConstants._();

  // Card styling
  static double cardBorderRadius = 12.0.r;
  static double cardMarginBottom = 16.0.h;
  static double cardPadding = 16.0.w;
  static double cardShadowBlurRadius = 8.0;
  static double cardShadowOpacity = 0.1;
  static Offset cardShadowOffset = const Offset(0, 2);

  // Map image
  static double mapImageHeight = 150.0.h;

  // Status badge
  static double statusBadgeHorizontalPadding = 8.0.w;
  static double statusBadgeVerticalPadding = 4.0.h;
  static double statusBadgeRadius = 8.0.r;
  static double statusBadgeFontSize = 12.0.sp;

  // Location indicators
  static double locationDotSize = 8.0.w;
  static double locationDotSpacing = 8.0.w;
  static double locationSpacing = 8.0.h;

  // Content spacing
  static double sectionSpacing = 12.0.h;

  // Icons
  static double smallIconSize = 16.0.w;
  static double iconTextSpacing = 4.0.w;

  // Text opacity values
  static double secondaryTextOpacity = 0.7;
  static double tertiaryTextOpacity = 0.6;

  // ListView padding
  static double listViewPadding = 16.0.w;

  // Service image
  static double serviceImageHeight = 60.0.h;
}

class RidesDetailsConstants {
  RidesDetailsConstants._();

  // Page padding
  static double pagePadding = 16.0.w;

  // Header
  static double headerIconSize = 24.0.w;
  static double headerSpacing = 16.0.w;
  static double headerBottomMargin = 16.0.h;

  // Map
  static double mapImageHeight = 200.0.h;
  static double mapBorderRadius = 12.0.r;

  // Cards
  static double cardElevation = 2.0;
  static double cardPadding = 16.0.w;
  static double cardMarginBottom = 16.0.h;
  static double cardBorderRadius = 12.0.r;

  // Icons
  static double locationIconSize = 20.0.w;
  static double timeIconSize = 20.0.w;
  static double starIconSize = 16.0.w;
  static double carIconSize = 20.0.w;
  static double paymentIconSize = 20.0.w;
  static double peopleIconSize = 16.0.w;
  static double luggageIconSize = 16.0.w;

  // Avatar
  static double avatarRadius = 20.0.r;
  static double avatarImageSize = 40.0.w;

  // Spacing
  static double iconTextSpacing = 8.0.w;
  static double smallSpacing = 4.0.w;
  static double mediumSpacing = 8.0.w;
  static double largeSpacing = 12.0.h;
  static double sectionSpacing = 16.0.h;

  // Chip containers
  static double chipHorizontalPadding = 8.0.w;
  static double chipVerticalPadding = 4.0.h;
  static double chipBorderRadius = 12.0.r;
  static double chipSpacing = 8.0.w;
}
