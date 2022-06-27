import 'package:ecellapp/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:ecellapp/screens/forgot_password/widgets/otp_field.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:ecellapp/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (state is ForgotEmailInitial)
                _initialForgotPassword(context, state)
              else if (state is ForgotLoading)
                _buildLoading(context)
              else if (state is ForgotOTPInitial)
                _enterOTP(context, state)
              else if (state is ForgotPasswordError)
                _uiUpdateForNetworkError(context, state.state)
              else if (state is ForgotResetInitial)
                _resetPassword(context, state)
              else if (state is ForgotResetSuccess)
                _passwordResetSuccess()
              else
                _initialForgotPassword(context, state)
            ],
          );
        },
      ),
    );
  }

  Widget _uiUpdateForNetworkError(BuildContext context, ForgotPasswordState state) {
    if (state is ForgotEmailInitial) {
      return _initialForgotPassword(context, state);
    } else if (state is ForgotOTPInitial) {
      return _enterOTP(context, state);
    } else if (state is ForgotPasswordError) {
      return _enterOTP(context, state);
    } else if (state is ForgotResetInitial) {
      return _resetPassword(context, state);
    } else {
      return _initialForgotPassword(context, state);
    }
  }

  Widget _initialForgotPassword(BuildContext context, ForgotPasswordState state) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter email"),
          EmailField(emailController),
          FlatButton(
              onPressed: () {
                _sendOTP(context, state);
              },
              child: Text("Press me")),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  Widget _enterOTP(BuildContext context, ForgotPasswordState state) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Enter otp"),
          OTPField(otpController),
          FlatButton(
              onPressed: () {
                _verifyOtp(context, state);
              },
              child: Text("Press me")),
        ],
      ),
    );
  }

  Widget _passwordResetSuccess() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Text("success"),
    );
  }

  Widget _resetPassword(BuildContext context, ForgotPasswordState state) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          PasswordField(passwordController),
          PasswordField(confirmPasswordController),
          FlatButton(
              onPressed: () {
                _changePassword(context, state);
              },
              child: Text("change password")),
        ],
      ),
    );
  }

  void _sendOTP(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.sendOTP(emailController.text, state);
  }

  void _verifyOtp(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.checkOTP(otpController.text, state, emailController.text);
  }

  void _changePassword(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.changePassword(emailController.text, otpController.text, passwordController.text,
        confirmPasswordController.text, state);
  }
}
