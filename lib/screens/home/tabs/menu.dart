import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/res/colors.dart';
import '../../../core/res/dimens.dart';
import '../../../core/res/strings.dart';
import '../../../core/utils/injection.dart';
import '../../../models/global_state.dart';
import '../../../widgets/ecell_animation.dart';
import '../../../widgets/screen_background.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.only(left: D.horizontalPadding - 10, top: 10),
          child: PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          ScreenBackground(elementId: 0),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: heightFactor * 350),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [C.eSummitButton1, C.eSummitButton2],
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: C.eSummitButton1.withOpacity(0.1),
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    constraints: BoxConstraints.tightFor(width: 70, height: 70),
                    child: GestureDetector(
                      child: Image.asset(
                        S.assetEsummitLogoWhiteFilled,
                        width: 30,
                        height: 30,
                      ),
                      onTap: () => Navigator.pushNamed(context, S.routeEsummit),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "E-Summit",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: C.primaryUnHighlightedColor),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: heightFactor * 75, right: width / 1.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [C.bQuizButton1, C.bQuizButton2],
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: C.bQuizButton1.withOpacity(0.1),
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    constraints: BoxConstraints.tightFor(width: 70, height: 70),
                    child: GestureDetector(
                      child:
                          Icon(Icons.search_rounded, size: 35, color: C.primaryUnHighlightedColor),
                      onTap: () => Navigator.pushNamed(context, S.routeBQuiz),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "BQuiz",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: C.primaryUnHighlightedColor),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: heightFactor * 75, left: width / 1.4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [C.eventsButton1, C.eventsButton2],
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: C.eventsButton2.withOpacity(0.1),
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    constraints: BoxConstraints.tightFor(width: 70, height: 70),
                    child: GestureDetector(
                      child: Image.asset(
                        S.assetEventsLogoWhite,
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, S.routeEvents);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Events",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: C.primaryUnHighlightedColor),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: heightFactor * 300, left: width / 2.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [C.sponsorsButton1, C.sponsorsButton2],
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          color: C.sponsorsButton2.withOpacity(0.1),
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    constraints: BoxConstraints.tightFor(width: 70, height: 70),
                    child: GestureDetector(
                      child: Image.asset(
                        S.assetSponsorsLogoWhite,
                        width: 25,
                        height: 25,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, S.routeSponsors);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sponsors",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: C.primaryUnHighlightedColor),
                  )
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: heightFactor * 300, right: width / 2.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [C.aboutUsButton1, C.aboutUsButton2],
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15,
                            color: C.aboutUsButton2.withOpacity(0.1),
                            offset: Offset(0, 5),
                          )
                        ]),
                    constraints: BoxConstraints.tightFor(width: 70, height: 70),
                    child: GestureDetector(
                      child: Icon(Icons.group, size: 35, color: C.primaryUnHighlightedColor),
                      onTap: () {
                        Navigator.pushNamed(context, S.routeAboutUs);
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "About Us",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: C.primaryUnHighlightedColor),
                  )
                ],
              ),
            ),
          ),
          Center(
              child: Container(
            child: ECellLogoAnimation(
              size: width / 3,
            ),
          )),
        ],
      ),
    );
  }

  Future<void> _handleClick(String value) async {
    switch (value) {
      case 'Logout':
        Provider.of<GlobalState>(context, listen: false).user = null;
        await sl.get<SharedPreferences>().remove(S.tokenKeySharedPreferences);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Logged Out Successfuly")));
        Navigator.pushReplacementNamed(context, S.routeLogin);
    }
  }
}
