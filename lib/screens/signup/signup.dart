import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/res/colors.dart';
import '../../core/res/dimens.dart';
import '../../core/res/strings.dart';
import '../../widgets/ecell_animation.dart';
import '../../widgets/email_field.dart';
import '../../widgets/password_field.dart';
import '../../widgets/screen_background.dart';
import '../login/cubit/login_cubit.dart';
import 'cubit/signup_cubit.dart';
import 'widgets/mobile_number_field.dart';
import 'widgets/name_field.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupError) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is SignupSuccess) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("SignUp Successful")));
            Navigator.pushReplacementNamed(context, S.routeLogin);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              ScreenBackground(elementId: 1),
              if (state is LoginLoading) _buildLoading(context) else _buildInitial(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInitial(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    if (_scrollController.hasClients) {
      if (bottom > height * 0.25) {
        _scrollController.animateTo(
          bottom - height * 0.25,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
    return DefaultTextStyle(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        controller: _scrollController,
        child: Container(
          height: height * 1.25,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(flex: 2, child: Container()),
              Flexible(
                flex: 7,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: D.horizontalPadding + 1),
                      child: Image.asset(
                        S.assetEcellLogoWhite,
                        width: width * 0.25 * heightFactor,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: D.horizontalPadding, top: 20),
                      child: Text(
                        "Hello!",
                        style: TextStyle(fontSize: 35 * heightFactor, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: D.horizontalPadding, top: 5),
                      child: RichText(
                        text: TextSpan(
                          text: "Let's create your ",
                          children: [
                            TextSpan(
                                text: "Account", style: TextStyle(color: C.primaryHighlightedColor))
                          ],
                          style: TextStyle(fontSize: 25 * heightFactor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: D.horizontalPadding),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(child: NameField(firstnameController, "First Name")),
                                SizedBox(width: 15),
                                Expanded(child: NameField(lastnameController, "Last Name")),
                              ],
                            ),
                            SizedBox(height: 20 * heightFactor),
                            EmailField(emailController),
                            SizedBox(height: 20 * heightFactor),
                            PasswordField(passwordController),
                            SizedBox(height: 20 * heightFactor),
                            MobileNumberField(mobileController),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
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
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      color: C.authButtonColor,
                      onPressed: () => _signup(context),
                      child: Container(
                        height: 60,
                        width: 120,
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up!",
                          style: TextStyle(
                            color: C.primaryUnHighlightedColor,
                            fontSize: 20 * heightFactor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: width / 8, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "have an account?",
                        style: TextStyle(fontSize: 18 * heightFactor, color: C.secondaryColor),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        child: Text(
                          "Login now",
                          style: TextStyle(
                            fontSize: 20 * heightFactor,
                            color: C.primaryHighlightedColor,
                          ),
                        ),
                        onTap: () => Navigator.pushReplacementNamed(context, S.routeLogin),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(flex: 3, child: Container()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _signup(BuildContext context) {
    final cubit = context.read<SignupCubit>();
    if (_formKey.currentState.validate())
      cubit.signup(
        firstnameController.text,
        lastnameController.text,
        emailController.text,
        mobileController.text,
        passwordController.text,
      );
  }
}
