import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';

import 'app_team_card.dart';


class AppTeamScreen extends StatelessWidget {
  AppTeamScreen({Key? key}) : super(key: key);

  AppTeamList appTeamList=AppTeamList();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height/1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [C.backgroundTop1, C.backgroundBottom1],
          ),
        ),
        child: DefaultTextStyle.merge(
          style: GoogleFonts.roboto().copyWith(
              color: C.primaryUnHighlightedColor),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "ECell App",
                      style: TextStyle(
                        fontSize: 55*heightFactor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 11,),
                    Text(
                      "Developer Team",
                      style: TextStyle(
                        fontSize: 55*heightFactor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 11,),
                    Column(children: appTeamList.createTeamList(2023)),
                    Container(
                      height: 40,
                      child: Text(
                        "Alumni App Dev",
                        style: TextStyle(
                          fontSize: 55*heightFactor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Column(children: appTeamList.createTeamList(2021)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


