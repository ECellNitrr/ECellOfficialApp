import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/email_field.dart';
import 'package:ecellapp/widgets/password_field.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) async {
          if (state is LoginSuccess) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text("Login Successful")));
            Navigator.pushReplacementNamed(context, S.routeSplash);
          } else if (state is LoginError) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
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
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height * 1.25,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Space for clouds
                  Expanded(flex: 2, child: Container()),
                  //Contains all fields
                  Flexible(
                    flex: 7,
                    child: Column(
                      children: [
                        // Logo
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
                            "Welcome",
                            style:
                                TextStyle(fontSize: 35 * heightFactor, fontWeight: FontWeight.w600),
                          ),
                        ),
                        //Text Greeting
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: D.horizontalPadding, top: 5),
                          child: RichText(
                            text: TextSpan(
                              text: "Let's ",
                              children: [
                                TextSpan(
                                    text: "Sign ",
                                    style: TextStyle(color: C.primaryHighlightedColor)),
                                TextSpan(
                                    text: "you in",
                                    style: TextStyle(color: C.primaryUnHighlightedColor)),
                              ],
                              style: TextStyle(fontSize: 25 * heightFactor),
                            ),
                          ),
                        ),
                        SizedBox(height: 23 * heightFactor),
                        //Fields
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: D.horizontalPadding),
                              child: Column(
                                children: [
                                  EmailField(emailController),
                                  SizedBox(height: 20 * heightFactor),
                                  PasswordField(passwordController),
                                  SizedBox(height: 10 * heightFactor),
                                ],
                              ),
                            )),
                        SizedBox(height: 20 * heightFactor),
                        //Redirect to Forgot Password
                        Container(
                          padding: EdgeInsets.only(right: D.horizontalPadding),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            child: Text(
                              "Forgot Password?",
                              style:
                                  TextStyle(fontSize: 20 * heightFactor, color: C.secondaryColor),
                            ),
                            onTap: () {
                              //TODO: Forgot Password Route
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  //LoginButton
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
                          onPressed: () => _login(context),
                          child: Container(
                            height: 60,
                            width: 120,
                            alignment: Alignment.center,
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: C.primaryUnHighlightedColor, fontSize: 20 * heightFactor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //New here Text
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: (width / 10), top: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('New here? ',
                              style:
                                  TextStyle(fontSize: 20 * heightFactor, color: C.secondaryColor)),
                          GestureDetector(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: C.primaryHighlightedColor,
                                  fontSize: 20 * heightFactor),
                            ),
                            onTap: () => Navigator.pushReplacementNamed(context, S.routeSignup),
                          ),
                        ],
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

  void _login(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    if (_formKey.currentState.validate())
      cubit.login(emailController.text, passwordController.text);
  }
}
