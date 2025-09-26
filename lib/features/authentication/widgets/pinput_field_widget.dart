import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

typedef PinputFieldOnCompleted = Function(String);

class PinputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final PinputFieldOnCompleted onCompleted;
  final FocusNode focusNode;
  const PinputFieldWidget({
    super.key,
    required this.controller,
    required this.onCompleted,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 1.sw,
      height: OtpCodeConstants.pinputHeight,
      textStyle: appTheme.textTheme.titleLarge?.copyWith(color: AppColors.secondary),
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(OtpCodeConstants.pinputBorderRadius),
      ),
    );

    return Pinput(
      controller: controller,
      preFilledWidget: Text(
        'X',
        style: appTheme.textTheme.titleLarge?.copyWith(color: AppColors.secondary),
      ),
      onTapOutside: (event) => focusNode.unfocus(),
      errorTextStyle: appTheme.textTheme.bodyMedium?.copyWith(color: AppColors.secondary),
      focusNode: focusNode,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      length: 4,
      defaultPinTheme: defaultPinTheme,
      onCompleted: onCompleted,
    );
  }
}
