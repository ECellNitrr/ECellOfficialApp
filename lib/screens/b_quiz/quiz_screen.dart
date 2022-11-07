import 'dart:async';

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/utils/network_checker.dart';
import 'package:ecellapp/models/questions.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/leaderboard_repository.dart';
import 'package:ecellapp/screens/b_quiz/quiz_success.dart';
import 'package:ecellapp/screens/b_quiz/widgets/question_card.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/raisedButton.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/ecell_animation.dart';
import '../../../widgets/reload_on_error.dart';
import '../../../widgets/stateful_wrapper.dart';
import '../../core/res/strings.dart';
import '../../models/global_state.dart';
import '../../models/user.dart';
import 'cubit/quiz_cubit.dart';
import 'widgets/option_card.dart';

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllQuizes(context),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [C.backgroundTop1, C.backgroundBottom1],
            ),
          ),
          child: BlocBuilder<QuizCubit, QuizState>(
            builder: (context, state) {
              print(state);
              if (state is QuizInitial)
                return _buildLoading(context);
              else if (state is QuizSuccess)
                return Success(QuizList: state.QuizList);
              else if (state is QuizLoading)
                return _buildLoading(context);
              else
                return ReloadOnErrorWidget(() => _getAllQuizes(context));
            },
          ),
        ),
      ),
    );
  }
}

StreamController<bool> streamController = StreamController<bool>.broadcast();

class Success extends StatefulWidget {
  final List<Questions> QuizList;

  Success({Key? key, required this.QuizList}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  final DataConnectionChecker connectionChecker = DataConnectionChecker();
  late StreamSubscription subscription;
  bool hasInternet = false;
  
  APILeaderRepository _apiLeaderRepository=APILeaderRepository(label: "DEMO");

  int score = 0;
  int currentQuestion = 1;
  int correctIndex = 0;
  int inputIndex = 0;
  int time = 0;
  final int _duration = 15;

  @override
  void initState() {
    super.initState();
    User user = context.read<GlobalState>().user!;
    subscription = connectionChecker.onStatusChange.listen((status) {
      final hasInternet = status == DataConnectionStatus.connected;
      if (!hasInternet) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Connection Lost'),
          backgroundColor: Colors.red,
        ));
        _apiLeaderRepository.uploadScore(score, user);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: ((context) =>
                QuizSuccessScreen(score: (score).toDouble()))));
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }
  
  final PageController _pageController = PageController(initialPage: 0);
  final CountDownController _countDownController = CountDownController();
  Future<bool> _onBackPressed() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Do you really want to close the Quiz?"),
            actions: [
              BackButton(
                text: "No",
                onpressed: () {
                  Navigator.pop(context, false);
                },
              ),
              BackButton(
                text: "Yes",
                onpressed: () {
                   User user = context.read<GlobalState>().user!;
                  Navigator.pop(context, true);
                  _apiLeaderRepository.uploadScore(score, user);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) =>
                          QuizSuccessScreen(score: (score).toDouble()))));
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    User user = context.read<GlobalState>().user!;
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double heightFactor = height / 1000;

    void callBack(int x, int y) {
      setState(() {
        inputIndex = x;
        correctIndex = y;

        print("$inputIndex $correctIndex");
      });
    }

    List<Widget> QuizContentList = [];
    widget.QuizList.forEach((element) => QuizContentList.add(QuestionCard(
          quiz: element,
          callBack: callBack,
          stream: streamController.stream,
        )));
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Stack(children: [
        ScreenBackground(elementId: 0),
        Container(
          width: width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GradientText("BQUIZ",
                        gradient: LinearGradient(
                          colors: [
                            C.bQuizGradient1,
                            C.bQuizGradient2,
                            C.bQuizGradient5,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )),
                    SizedBox(
                      width: 20.0,
                    ),
                    CircularCountDownTimer(
                      duration: _duration,
                      initialDuration: 0,
                      controller: _countDownController,
                      width: MediaQuery.of(context).size.width / 7,
                      height: MediaQuery.of(context).size.height / 10,
                      ringColor: Colors.grey[300]!,
                      fillColor: Colors.purpleAccent[100]!,
                      backgroundColor: Colors.purple[500],
                      strokeWidth: 10.0,
                      strokeCap: StrokeCap.round,
                      textStyle: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textFormat: CountdownTextFormat.S,
                      isReverse: true,
                      isReverseAnimation: false,
                      isTimerTextShown: true,
                      autoStart: true,
                      onStart: () {
                        debugPrint('Countdown Started');
                      },
                      onComplete: () {
                        time = int.parse(_countDownController.getTime().toString());
                        debugPrint('Countdown Ended');
                        if (_pageController.page !=
                            QuizContentList.length - 1) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeInOut);

                          Future.delayed(Duration(milliseconds: 1500), () {
                            _countDownController.restart(duration: _duration);
                          });
                        } else {
                            print("time:$time");
                            print("$inputIndex---$correctIndex");
                            if (inputIndex != 0 &&
                                correctIndex != 0 &&
                                inputIndex == correctIndex) {
                              streamController.add(true);
                              score += calcScore(time);
                              print("Score:$score");
                            } else {
                              streamController.add(false);
                            }
                          _apiLeaderRepository.uploadScore(score, user);
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: ((context) => QuizSuccessScreen(
                                      score: (score).toDouble()))));
                          _countDownController.pause();
                        }
                        if (_pageController.page !=QuizContentList.length - 1) { setState(() {
                          currentQuestion += 1;
                          print("time:$time");
                          print("$inputIndex---$correctIndex");
                          if (inputIndex != 0 &&
                              correctIndex != 0 &&
                              inputIndex == correctIndex) {
                            streamController.add(true);
                            score += calcScore(time);
                            print("Score:$score");
                          } else {
                            streamController.add(false);
                          }
                        });};
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Question $currentQuestion",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Score: $score",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Expanded(
                    child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        scrollDirection: Axis.horizontal,
                        children: QuizContentList),
                  ),
                ),
              ]),
        ),
        Positioned(
          right: 15.0,
          bottom: 15.0,
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
            child: LegacyFlatButtonShape(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              color: Colors.transparent,
              onPressed: () {
                time = int.parse(_countDownController.getTime().toString());
                if (_pageController.page != QuizContentList.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeInOut,
                  );

                  Future.delayed(Duration(milliseconds: 1500), () {
                    _countDownController.restart(duration: _duration);
                  });
                } else {
                  print("Last Question update after pressing next");
                  print("time:$time");
                  print("$inputIndex---$correctIndex");
                  if (inputIndex != 0 &&
                      correctIndex != 0 &&
                      inputIndex == correctIndex) {
                    streamController.add(true);
                    score += calcScore(time);
                    print("Score:$score");
                  } else {
                    streamController.add(false);
                  }
                  _apiLeaderRepository.uploadScore(score, user);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) =>
                          QuizSuccessScreen(score: (score).toDouble()))));
                  _countDownController.pause();
                }
                if (_pageController.page != QuizContentList.length - 1) { setState(() {
                  currentQuestion += 1;
                  print("SetState");
                  print("time:$time");
                  print("$inputIndex---$correctIndex");
                  if (inputIndex != 0 &&
                      correctIndex != 0 &&
                      inputIndex == correctIndex) {
                    streamController.add(true);
                    score += calcScore(time);
                    print("Score:$score");
                  } else {
                    streamController.add(false);
                  }
                });};
              },
              child: Container(
                height: 30,
                width: 120,
                alignment: Alignment.center,
                child: Text(
                  "NEXT",
                  style: TextStyle(
                    letterSpacing: 0.75,
                    color: C.primaryUnHighlightedColor,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

Widget _buildLoading(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Center(child: ECellLogoAnimation(size: width / 2));
}

void _getAllQuizes(BuildContext context) {
  final cubit = context.read<QuizCubit>();
  cubit.getQuizList();
}

int calcScore(int time) {
  int score = 10 + (time + 15) * 10;
  return score;
}

class BackButton extends StatelessWidget {
  final String text;
  final Function onpressed;
  const BackButton({Key? key, required this.text, required this.onpressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onPressed: onpressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          color: Colors.transparent,
          child: Text(
            text,
            style: TextStyle(
              letterSpacing: 0.75,
              color: C.primaryUnHighlightedColor,
              fontSize: 26,
            ),
          )),
    );
  }
}