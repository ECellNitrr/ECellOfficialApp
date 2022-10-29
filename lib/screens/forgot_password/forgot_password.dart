import 'package:ecellapp/screens/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:ecellapp/screens/forgot_password/widgets/otp_field.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:ecellapp/widgets/password_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../core/res/colors.dart';
import '../../core/res/dimens.dart';
import '../../core/res/strings.dart';
import '../../widgets/raisedButton.dart';
import '../../widgets/screen_background.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.only(left: D.horizontalPadding - 10, top: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ScreenBackground(elementId: 1),
              if (state is ForgotEmailInitial)
                _resetPassword(context, state)
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

  Widget _uiUpdateForNetworkError(
      BuildContext context, ForgotPasswordState state) {
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

  Widget _initialForgotPassword(
      BuildContext context, ForgotPasswordState state) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    return DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Space for clouds
                  Expanded(flex: 2, child: Container()),
                  Expanded(flex: 2, child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Step 1/3",
                      style: TextStyle(
                          fontSize: 35 * heightFactor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),),
                  //Contains all fields
                  Flexible(
                    flex: 6,
                    child: Column(
                      children: [
                        // Logo
                        Container(
                          alignment: Alignment.centerLeft,
                          padding:
                          EdgeInsets.only(left: D.horizontalPadding + 1),
                          child: Image.asset(
                            S.assetEcellLogoWhite,
                            width: width * 0.30 * heightFactor,
                          ),
                        ),
                        SizedBox(height: 23 * heightFactor),
                        //Text Greeting
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: D.horizontalPadding, top: 5),
                          child: RichText(
                            text: TextSpan(
                              text: "Forgot your ",
                              children: [
                                TextSpan(
                                    text: "password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        color: C.primaryHighlightedColor)),
                                TextSpan(
                                    text: "?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w200,
                                        color: C.primaryUnHighlightedColor)),
                              ],
                              style: TextStyle(fontSize: 25 * heightFactor,fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: D.horizontalPadding, top: 5),
                          child: RichText(
                            text: TextSpan(
                              text: "We have got you covered.",
                              style: TextStyle(fontSize: 25 * heightFactor,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                              left: D.horizontalPadding, top: 5),
                          child: RichText(
                            text: TextSpan(
                              text: "Just enter your registered user email.",
                              style: TextStyle(fontSize: 25 * heightFactor,
                                  fontWeight: FontWeight.w200),
                            ),
                          ),
                        ),
                        SizedBox(height: 28* heightFactor),
                        //Fields
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: D.horizontalPadding),
                              child: Column(
                                children: [
                                  EmailField(emailController),
                                  SizedBox(height: 20 * heightFactor),
                                ],
                              ),
                            )),
                        SizedBox(height: 20 * heightFactor),
                        //Redirect to Forgot Password
                      ],
                    ),
                  ),
                  //LoginButton
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(right: D.horizontalPadding),
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: C.authButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 12),
                            )
                          ],
                        ),
                        child: LegacyRaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          color: C.authButtonColor,
                          onPressed: () {
                            _enterOTP(context, state);
                          },
                          child: Container(
                            height: 50,
                            width: 115,
                            alignment: Alignment.center,
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: C.primaryUnHighlightedColor,
                                  fontSize: 28 * heightFactor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //To flex background
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  Widget _enterOTP(BuildContext context, ForgotPasswordState state) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    return DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Space for clouds
                  Expanded(flex: 2, child: Container()),
                  Expanded(flex: 2, child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Step 2/3",
                      style: TextStyle(
                          fontSize: 35 * heightFactor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),),
                  //Contains all fields
                  Flexible(
                    flex: 7,
                    child: Column(
                      children: [
                        // Logo
                        Container(
                          alignment: Alignment.center,
                          child:Stack(
                            alignment: Alignment.center,
                            children: [
                              Icon(Icons.shield,size: 55.0,color: Colors.white,),
                              Icon(Icons.check_rounded,size: 45.0,color: Colors.black),
                            ],
                          )
                        ),
                        SizedBox(height: 23 * heightFactor),
                        //Text Greeting
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                                text: "Verify OTP",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    color: C.primaryHighlightedColor,
                                    fontSize: 25 * heightFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 28* heightFactor),
                        Container(
                          padding: EdgeInsets.fromLTRB(D.horizontalPadding,0,D.horizontalPadding,0),
                          alignment: Alignment.center,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "An OTP has been sent to the registered user email",
                              style: TextStyle(
                                  fontSize: 20 * heightFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 28* heightFactor),
                        //Fields
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: D.horizontalPadding),
                              child: Column(
                                children: [
                                  OTPField(otpController),
                                  SizedBox(height: 20 * heightFactor),
                                ],
                              ),
                            )),
                        SizedBox(height: 15 * heightFactor),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: RichText(
                                text: TextSpan(
                                  text: "You can request another otp in ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                      fontSize: 22 * heightFactor),
                                ),
                              ),
                            ),
                            Countdown(
                              seconds: 16,
                              build: (BuildContext context, double time) => Text("${(time.toInt()).toString()}s",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                    fontSize: 22 * heightFactor
                                ),),
                              interval: Duration(milliseconds: 100),
                              onFinished: () {
                                print('Timer is done!');
                              },
                            )
                          ],
                        ),

                      ],
                    ),
                  ),

                  //Button
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //resend button
                        Container(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color:
                              Colors.white,width: 2),
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                            ),
                            child: LegacyRaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              color: Colors.transparent,
                              onPressed: () {
                                _sendOTP(context, state);
                              },
                              child: Container(
                                height: 50,
                                width: 110,
                                alignment: Alignment.center,
                                child: Text(
                                  "Resend",
                                  style: TextStyle(
                                      color: C.primaryUnHighlightedColor,
                                      fontSize: 20 * heightFactor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //submit button
                        Container(
                          alignment: Alignment.topRight,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: C.authButtonColor.withOpacity(0.2),
                                  blurRadius: 10,
                                  spreadRadius: 3,
                                  offset: Offset(0, 12),
                                )
                              ],
                            ),
                            child: LegacyRaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                              ),
                              color: C.authButtonColor,
                              onPressed: () {
                                _verifyOtp(context, state);
                              },
                              child: Container(
                                height: 55,
                                width: 110,
                                alignment: Alignment.center,
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                      color: C.primaryUnHighlightedColor,
                                      fontSize: 20 * heightFactor),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //To flex background
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
          )
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return  DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Space for clouds
                  Expanded(flex: 2, child: Container()),
                  Expanded(flex: 2, child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Step 3/3",
                      style: TextStyle(
                          fontSize: 35 * heightFactor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),),
                  //Contains all fields
                  Flexible(
                    flex: 6,
                    child: Column(
                      children: [
                        SizedBox(height: 25 * heightFactor),
                        //Text Greeting
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                                text: "Reset Password",
                                style: TextStyle(
                                    color: C.primaryHighlightedColor,
                                  fontSize: 28 * heightFactor
                                )),
                          ),
                        ),
                        SizedBox(height: 50 * heightFactor),
                        Container(
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Please enter your new password",
                              style: TextStyle(fontSize: 23 * heightFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 40* heightFactor),
                        //Fields
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: D.horizontalPadding),
                              child: Column(
                                children: [
                                  PasswordField(passwordController,"New Password"),
                                  SizedBox(height: 30 * heightFactor),
                                  PasswordField(confirmPasswordController,"Confirm Password"),
                                ],
                              ),
                            )),
                        SizedBox(height: 20 * heightFactor),
                        //Redirect to Forgot Password
                      ],
                    ),
                  ),
                  //LoginButton
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(right: D.horizontalPadding),
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                              color: C.authButtonColor.withOpacity(0.2),
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(0, 12),
                            )
                          ],
                        ),
                        child: LegacyRaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          color: C.authButtonColor,
                          onPressed: () {
                            _changePassword(context, state);
                          },
                          child: Container(
                            height: 60,
                            width: 120,
                            alignment: Alignment.center,
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  color: C.primaryUnHighlightedColor,
                                  fontSize: 30 * heightFactor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //To flex background
                  Expanded(flex: 3, child: Container()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


  void _sendOTP(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    if (_formKey.currentState!.validate())
      cubit.sendOTP(emailController.text, state);
  }

  void _verifyOtp(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.checkOTP(otpController.text, state, emailController.text);
  }

  void _changePassword(BuildContext context, ForgotPasswordState state) {
    final cubit = context.read<ForgotPasswordCubit>();
    cubit.changePassword(emailController.text, otpController.text,
        passwordController.text, confirmPasswordController.text, state);
  }
}

