import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/core/theme/colors.dart';
import 'package:imove_challenge/core/theme/app_theme.dart';
import 'package:imove_challenge/core/theme/theme_constants.dart';
import 'package:imove_challenge/features/authentication/extensions/valid_phone_number_extension.dart';
import 'package:imove_challenge/features/authentication/widgets/phone_number_field_widget.dart';

import 'package:imove_challenge/features/authentication/bloc/authentication_bloc.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_event.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_state.dart';
import 'package:imove_challenge/features/authentication/controller/phone_verification_controller.dart';
import 'package:imove_challenge/core/widgets/base_scaffold.dart';

class PhoneVerificationView extends StatefulWidget {
  const PhoneVerificationView({super.key});

  @override
  State<PhoneVerificationView> createState() => _PhoneVerificationViewState();
}

class _PhoneVerificationViewState extends State<PhoneVerificationView> {
  final GetIt getIt = GetIt.instance;
  late final PhoneVerificationController _phoneVerificationController;
  late AuthenticationBloc _authenticationBloc;
  String? _phoneNumber;
  static const int _userType = 2;

  @override
  initState() {
    super.initState();
    _authenticationBloc = getIt.get<AuthenticationBloc>();
    _phoneVerificationController = PhoneVerificationController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: BaseScaffold(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            _phoneVerificationController.handleState(
              state: state,
              context: context,
              identity: _phoneNumber!,
              userType: _userType.toString(),
            );
          },
          builder: (context, state) {
            return Column(
              spacing: AppThemeConstants.vPaddingLarge,
              children: [
                Spacer(),
                Text('iMove', style: appTheme.textTheme.titleLarge),
                PhoneNumberFieldWidget(
                  placeholder: 'Enter your phone number',
                  onChanged: (value) {
                    _phoneNumber = value;
                    setState(() {});
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    if (!_phoneNumber.isValidPhoneNumber) return;
                    _authenticationBloc.add(
                      SendPhoneNumberEvent(phoneNumber: _phoneNumber!, userType: _userType),
                    );
                  },
                  child: Container(
                    width: 1.sw,
                    padding: EdgeInsets.symmetric(vertical: AppThemeConstants.vPaddingSmall),
                    decoration: BoxDecoration(
                      color: _phoneNumber.isValidPhoneNumber
                          ? AppColors.secondary
                          : AppColors.darkGray,
                      borderRadius: BorderRadius.circular(AppThemeConstants.borderRadiusLarge),
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: _phoneNumber.isValidPhoneNumber
                              ? AppColors.pageDefault
                              : AppColors.secondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }
}
