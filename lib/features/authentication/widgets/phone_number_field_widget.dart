// ignore_for_file: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/constants/reg_exp_helper.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';

typedef PhoneNumberFieldOnChanged = Function(String);

class PhoneNumberFieldWidget extends StatefulWidget {
  final String placeholder;
  final PhoneNumberFieldOnChanged? onChanged;
  const PhoneNumberFieldWidget({super.key, this.onChanged, required this.placeholder});

  @override
  State<PhoneNumberFieldWidget> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberFieldWidget> {
  final TextEditingController _numberController = TextEditingController();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final TextInputType _keyboardType = TextInputType.number;
  final getIt = GetIt.instance;

  @override
  void dispose() {
    _numberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoTextField(
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          controller: _numberController,
          focusNode: _phoneNumberFocusNode,
          keyboardType: _keyboardType,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExpHelper.phoneNumberRegExp)],
          enableSuggestions: false,
          onChanged: widget.onChanged,
          autocorrect: false,
          cursorColor: AppColors.secondary,
          placeholder: widget.placeholder,
          padding: EdgeInsets.symmetric(
            horizontal: AppThemeConstants.hPaddingLarge,
            vertical: AppThemeConstants.vPaddingSmall,
          ),
          decoration: BoxDecoration(
            color: AppColors.darkGray,
            borderRadius: BorderRadius.circular(AppThemeConstants.borderRadiusLarge),
          ),
        ),
      ],
    );
  }
}
