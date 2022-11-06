import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';

import '../../../../core/res/strings.dart';
import '../../../../widgets/raisedButton.dart';


class TeamList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Stack(children: [
        ScreenBackground(elementId: 1),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GradientText("TEAMS",
                      gradient: LinearGradient(
                        colors: [
                          C.bQuizGradient1,
                          C.bQuizGradient2,
                          C.bQuizGradient3,
                          C.bQuizGradient4,
                          C.bQuizGradient5,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )),
                  SizedBox(width: 8),
                  GradientText("LIST",
                      gradient: LinearGradient(
                        colors: [
                          C.bQuizGradient1,
                          C.bQuizGradient2,
                          C.bQuizGradient3,
                          C.bQuizGradient4,
                          C.bQuizGradient5,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListButtonT(text: 'Team of 2010-11', year: 2010),
              ListButtonT(text: 'Team of 2011-12', year: 2011),
              ListButtonT(text: 'Team of 2012-13', year: 2012),
              ListButtonT(text: 'Team of 2013-14', year: 2013),
              ListButtonT(text: 'Team of 2014-15', year: 2014),
              ListButtonT(text: 'Team of 2015-16', year: 2015),
              ListButtonT(text: 'Team of 2016-17', year: 2016),
              ListButtonT(text: 'Team of 2017-18', year: 2017),
              ListButtonT(text: 'Team of 2018-19', year: 2018),
              ListButtonT(text: 'Team of 2019-20', year: 2019),
              ListButtonT(text: 'Team of 2020-21', year: 2020),
              ListButtonT(text: 'Team of 2022-23', year: 2022),
            ],
          ),
        ),
      ]),
    );
  }
}

class ListButtonT extends StatelessWidget {

  ListButtonT({required this.text, required this.year});
  final String text;
  final int year;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    C.bQuizGradient1,
                    C.bQuizGradient2,
                    C.bQuizGradient3,
                    C.bQuizGradient4,
                    C.bQuizGradient5,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: LegacyRaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                color: Colors.transparent,
                onPressed: () {
                  S.teamApiYear=year;
                  print(S.teamApiYear);
                  print(S.getTeamUrl);
                  Navigator.pushReplacementNamed(context,S.routeAboutUs);
                },
                child: Container(
                  height: 70,
                  width: width*0.7,
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                      letterSpacing: 0.75,
                      color: C.primaryUnHighlightedColor,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
