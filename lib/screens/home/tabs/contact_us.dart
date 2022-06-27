import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:ecellapp/screens/home/cubit/feedback_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController feedbackController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocConsumer<FeedbackCubit, FeedbackState>(listener: (context, state) {
          if (state is FeedbackError) {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is FeedbackSuccess) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("Feedback Posted Successful")));
          }
        }, builder: (context, state) {
          if (state is FeedbackLoading) {
            return _buildLoading();
          } else {
            return _buildInitial(context);
          }
        }));
  }

  Widget _buildInitial(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).viewPadding.top;
    double bottom = MediaQuery.of(context).viewInsets.bottom;
    double heightFactor = height / 1000;
    if (_scrollController.hasClients) {
      if (bottom > height * 0.1) {
        _scrollController.animateTo(
          bottom - height * 0.15,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      } else {
        _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.ease);
      }
    }
    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          ScreenBackground(elementId: 0),
          SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            controller: _scrollController,
            child: Container(
              height: height * 1.5,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 20 * heightFactor, left: D.horizontalPadding),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: top + 20 * heightFactor),
                    child: Text(
                      "Contact Us",
                      style: TextStyle(fontSize: 45 * heightFactor, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50 * heightFactor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          S.assetLocationIcon,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(S.addressURL),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "National Institute of Technology",
                                style: TextStyle(
                                    fontSize: 20 * heightFactor,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    wordSpacing: 4),
                              ),
                              Text(
                                "GE Road, Raipur",
                                style: TextStyle(
                                    fontSize: 20 * heightFactor,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2,
                                    wordSpacing: 4),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30 * heightFactor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          S.assetPhoneIcon,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(S.phoneURL),
                          child: Text(
                            S.ecellPhone,
                            style: TextStyle(
                                fontSize: 20 * heightFactor,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                wordSpacing: 4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30 * heightFactor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          S.assetGmailIcon,
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        GestureDetector(
                          onTap: () => _launchURL(S.emailURL),
                          child: Text(
                            S.ecellEmail,
                            style: TextStyle(
                                fontSize: 20 * heightFactor,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                                wordSpacing: 4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 50 * heightFactor, right: D.horizontalPadding),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => _launchURL(S.linkedinURL),
                            child: Image.asset(
                              S.assetLinkedinIcon,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => _launchURL(S.twitterURL),
                            child: Image.asset(
                              S.assetTwitterIcon,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => _launchURL(S.facebookURL),
                            child: Image.asset(
                              S.assetFacebookIcon,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () => _launchURL(S.instagramURL),
                            child: Image.asset(
                              S.assetInstagramIcon,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: 50 * heightFactor),
                    child: Text(
                      "Feedback",
                      style: TextStyle(fontSize: 40 * heightFactor, fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20 * heightFactor),
                    child: Row(
                      children: [
                        Text(
                          S.feedbackLine,
                          style: TextStyle(
                              fontSize: 20 * heightFactor,
                              fontWeight: FontWeight.w300,
                              height: 1.2,
                              wordSpacing: 4),
                        ),
                        Image.asset(
                          S.assetHeartIcon,
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20 * heightFactor, right: D.horizontalPadding),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Image.asset(
                            S.assetFeedbackIcon,
                            width: 30,
                            height: 30,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 10,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: feedbackController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                color: C.primaryUnHighlightedColor,
                                fontSize: D.inputFieldFontSize * heightFactor,
                              ),
                              validator: _validator,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(fontSize: 0.1),
                                labelText: "message",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: D.horizontalPadding, top: 40),
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
                          ),
                        ],
                      ),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        color: C.authButtonColor,
                        onPressed: () => _postFeedback(context),
                        child: Container(
                          height: 50,
                          width: 120,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Submit",
                                style: TextStyle(
                                  color: C.primaryUnHighlightedColor,
                                  fontSize: 20 * heightFactor,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, 0.5),
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String _validator(String text) => text.isEmpty ? "" : null;
  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  void _postFeedback(BuildContext context) {
    final cubit = context.read<FeedbackCubit>();
    if (_formKey.currentState.validate()) cubit.postFeedback(feedbackController.text);
  }
}
