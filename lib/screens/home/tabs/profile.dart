import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/dimens.dart';
import '../../../core/res/strings.dart';
import '../../../models/global_state.dart';
import '../../../models/user.dart';
import '../../../widgets/screen_background.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    User user = context.read<GlobalState>().user;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).viewPadding.top;
    double heightFactor = height / 1000;
    return Scaffold(
      body: DefaultTextStyle(
        style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
        child: Stack(
          children: [
            ScreenBackground(elementId: 0),
            Container(
              padding: EdgeInsets.only(top: 56 + top + 20 * heightFactor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Image.asset(
                      S.assetEcellLogoWhite,
                      width: width * 0.3 * heightFactor,
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 10,
                    child: Form(
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: D.horizontalPadding, right: D.horizontalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _label("First Name", heightFactor),
                            _labelValue(width, height, user.firstName),
                            Expanded(flex: 1, child: Container()),
                            _label("Last Name", heightFactor),
                            _labelValue(width, height, user.lastName),
                            Expanded(flex: 1, child: Container()),
                            _label("Email Address", heightFactor),
                            _labelValue(width, height, user.email),
                            Expanded(flex: 1, child: Container()),
                            _label("Phone Number", heightFactor),
                            _labelValue(width, height, user.phoneNumber),
                            Expanded(flex: 1, child: Container()),
                            Container(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {}, //TODO
                                child: Text(
                                  "Change Password?",
                                  style: TextStyle(
                                    color: C.primaryHighlightedColor,
                                    fontSize: 20 * heightFactor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 5, child: Container())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String label, double fontSize) {
    return Text(
      label,
      style: TextStyle(
        color: C.primaryUnHighlightedColor,
        fontSize: 15 * fontSize,
        fontWeight: FontWeight.w100,
        letterSpacing: 1.3,
      ),
    );
  }

  Widget _labelValue(double width, double height, String value) {
    return Container(
      width: width,
      padding: EdgeInsets.only(top: height / 100, bottom: 5),
      child: Text(
        value,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, letterSpacing: 1.2),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: C.primaryUnHighlightedColor),
        ),
      ),
    );
  }
}
