import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/screens/b_quiz/cubit/quiz_cubit.dart';
import 'package:ecellapp/screens/b_quiz/cubit/quiz_details_cubit.dart';
import 'package:ecellapp/screens/b_quiz/leaderboard_list.dart';
import 'package:ecellapp/screens/b_quiz/quiz_detail_repository.dart';
import 'package:ecellapp/screens/b_quiz/quiz_list.dart';
import 'package:ecellapp/screens/b_quiz/quiz_repository.dart';
import 'package:ecellapp/screens/b_quiz/quiz_screen.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecellapp/screens/login/login.dart';
import 'package:ecellapp/core/res/strings.dart';
import '../../widgets/raisedButton.dart';
import '../login/cubit/login_cubit.dart';
import '../login/login_repository.dart';
import 'leaderBoard/cubit/leaderboard_cubit.dart';
import 'leaderBoard/leader_board.dart';
import 'leaderBoard/leaderboard_repository.dart';
import 'package:ecellapp/models/global_state.dart';
import 'package:ecellapp/models/user.dart' as uo;
import 'package:provider/provider.dart';
final GlobalKey<ScaffoldMessengerState> snackbarKey =
    GlobalKey<ScaffoldMessengerState>();

class BQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(context.read<GlobalState>().user?.firstName=="Guest"){
      return Provider(
          create: (_) => LoginCubit(APILoginRepository()),
          child: LoginScreen(),
      );
    }
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: D.horizontalPadding - 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 25),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),
      body: Stack(children: [
        ScreenBackground(elementId: 2),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText("BUSINESS",
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
              GradientText("QUIZ",
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
              Text(
                "Quicker Answers, More Points",
                style: TextStyle(
                    color: C.secondaryColor, fontSize: 25 * heightFactor),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(right: D.horizontalPadding),
                alignment: Alignment.topRight,
                child: Column(
                  children: [
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
                                  create: (_) => QuizDetailCubit(
                                      APIQuizDetailRepository()),
                                  child: QuizList()))));
                        },

                        child: Container(
                          height: 30,
                          width: 120,
                          alignment: Alignment.center,
                          child: Text(
                            "START",
                            style: TextStyle(
                              letterSpacing: 0.75,
                              color: C.primaryUnHighlightedColor,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent),
                        foregroundColor: MaterialStateProperty.all(Colors.transparent),
                        shadowColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => BlocProvider(
                                create: (_) =>
                                    QuizDetailCubit(APIQuizDetailRepository()),
                                child: LeaderList()))));
                        
                      },
                      child: Text(
                        "Leaderboard",
                        style: TextStyle(
                          color: C.primaryUnHighlightedColor,
                          fontSize: 20 * heightFactor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}