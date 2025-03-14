import 'package:confetti/confetti.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/screens/b_quiz/cubit/quiz_details_cubit.dart';
import 'package:ecellapp/screens/b_quiz/leaderboard_list.dart';
import 'package:ecellapp/screens/b_quiz/quiz_detail_repository.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/res/strings.dart';
import '../../widgets/raisedButton.dart';

class QuizSuccessScreen extends StatefulWidget {
  QuizSuccessScreen({required this.score});
  final double score;
  @override
  State<QuizSuccessScreen> createState() =>
      _QuizSuccessScreenState(score: score);
}

class _QuizSuccessScreenState extends State<QuizSuccessScreen> {
  _QuizSuccessScreenState({required this.score});
  final double score;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.play();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double heightFactor = height / 1000;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(alignment: Alignment.topCenter, children: [
        ScreenBackground(elementId: 3),
        Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText("SUCCESS",
                  gradient: LinearGradient(
                    colors: [
                      Colors.yellowAccent,
                      Colors.yellow,
                      Colors.orangeAccent,
                      Colors.orangeAccent,
                      Colors.deepOrangeAccent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )),
              SizedBox(height: 20),
              Container(
                height: width * 0.6,
                child: Image.asset(S.assetBquizMedal, fit: BoxFit.fill),
              ),
              SizedBox(height: 20),
              Text(
                "Congratulations!",
                style: TextStyle(
                    // The color must be set to white for this to work
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "Your score is: $score",
                style: TextStyle(
                    // The color must be set to white for this to work
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 25),
              Container(
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
                  borderRadius: BorderRadius.all(Radius.circular(width * 0.1)),
                ),
                child: LegacyRaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * 0.1)),
                  ),
                  color: Colors.transparent,
                  onPressed: () {
                    dispose();
                    //TODO: Function to send score and user data to firebase
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: ((context) => BlocProvider(
                            create: (_) =>
                                QuizDetailCubit(APIQuizDetailRepository()),
                            child: LeaderList()))));
                  },
                  child: Container(
                    height: width * 0.2,
                    width: width * 0.6,
                    alignment: Alignment.center,
                    child: Text(
                      "LEADERBOARD",
                      style: TextStyle(
                        letterSpacing: 0.75,
                        color: C.primaryUnHighlightedColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
            ],
          ),
        ),
        ConfettiWidget(
          emissionFrequency: 0.08,
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
        ),
      ]),
    );
  }
}
