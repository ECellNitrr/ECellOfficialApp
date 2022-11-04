import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/leader_board.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/res/strings.dart';
import '../../widgets/raisedButton.dart';

import 'leaderBoard/cubit/leaderboard_cubit.dart';
import 'leaderBoard/leaderboard_repository.dart';

class LeaderList extends StatelessWidget {
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
        ScreenBackground(elementId:3),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Container(
              width: MediaQuery.of(context).size.width,
              child: GradientText(
                "LEADERBOARDS",
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
                ),
              ),
            ),
            SizedBox(height: 20),
            ListButton(
              text: 'DEMO',
            ),
            ListButton(
              text: 'November 27',
            ),
            ListButton(
              text: 'November 28',
            ),
            ListButton(
              text: 'November 29',
            ),
            ListButton(
              text: 'November 30',
            ),
            ListButton(text: 'December 1')
          ],
        ),
      ]),
    );
  }
}

class ListButton extends StatelessWidget {
  APILeaderRepository apiQuizRepository =
      new APILeaderRepository(label: 'demo');
  ListButton({required this.text});
  final String text;

  // List<int> dateTime = List.empty();
  // final int month;
  // final int day;
  // final int startHr;
  // final int endHr;

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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => BlocProvider(
                          create: (_) =>
                              LeaderCubit(APILeaderRepository(label: text)),
                          child: LeaderScreen()))));
                },
                child: Container(
                  height: 70,
                  width: width * 0.7,
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
