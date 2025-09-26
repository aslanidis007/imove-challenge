import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:imove_challenge/features/authentication/controller/otp_code_controller.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_bloc.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_event.dart';
import 'package:imove_challenge/features/authentication/bloc/authentication_state.dart';
import 'package:imove_challenge/core/widgets/base_scaffold.dart';
import 'package:imove_challenge/features/authentication/widgets/pinput_field_widget.dart';

class OtpCodeView extends StatefulWidget {
  final String verificationId;
  final int userType;
  final String identity;
  const OtpCodeView({
    super.key,
    required this.verificationId,
    required this.userType,
    required this.identity,
  });

  @override
  State<OtpCodeView> createState() => _OtpCodeViewState();
}

class _OtpCodeViewState extends State<OtpCodeView> {
  final GetIt getIt = GetIt.instance;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final AuthenticationBloc _authenticationBloc;
  late final OtpCodeController _otpCodeController;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _authenticationBloc = getIt.get<AuthenticationBloc>();
    _otpCodeController = OtpCodeController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _authenticationBloc,
      child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          _otpCodeController.handleState(state: state, context: context);
        },
        builder: (context, state) {
          return BaseScaffold(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PinputFieldWidget(
                  controller: _controller,
                  onCompleted: (value) {
                    _authenticationBloc.add(
                      VerifyOtpCodeEvent(
                        identity: widget.identity,
                        code: value,
                        verificationId: widget.verificationId,
                        userType: widget.userType,
                      ),
                    );
                  },
                  focusNode: _focusNode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
