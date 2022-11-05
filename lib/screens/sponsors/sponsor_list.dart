import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';

import '../../core/res/strings.dart';
import '../../widgets/raisedButton.dart';

class SponsorList extends StatelessWidget {
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText("SPONSOR",
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
            ListButton(text: 'Sponsors 2015', year: 2015),
            ListButton(text: 'Sponsors 2016', year: 2016),
            ListButton(text: 'Sponsors 2017', year: 2017),
            ListButton(text: 'Sponsors 2018', year: 2018),
            ListButton(text: 'Sponsors 2019', year: 2019),
            ListButton(text: 'Sponsors 2022', year: 2022),
          ],
        ),
      ]),
    );
  }
}

class ListButton extends StatelessWidget {

  ListButton({required this.text, required this.year});
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
                  S.sponsorApiYear=year;
                  print(S.sponsorApiYear);
                  print(S.getSponsorsUrl);
                  Navigator.pushNamed(context,S.routeSponsors);
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
