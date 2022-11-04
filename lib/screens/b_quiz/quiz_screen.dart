import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/models/questions.dart';
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
import 'cubit/quiz_cubit.dart';
import 'widgets/option_card.dart';

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllQuizes(context),
      child: Scaffold(
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            print(state);
            if (state is QuizInitial)
              return _buildLoading(context);
            else if (state is QuizSuccess)
              return _buildSuccess(context, state.QuizList);
            else if (state is QuizLoading)
              return _buildLoading(context);
            else
              return ReloadOnErrorWidget(() => _getAllQuizes(context));
          },
        ),
      ),
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

Widget _buildSuccess(BuildContext context, List<Questions> QuizList) {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);
  final CountDownController _countDownController = CountDownController();

  final int _duration = 10;

  double ratio = MediaQuery.of(context).size.aspectRatio;
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  double heightFactor = height / 1000;

  List<Widget> QuizContentList = [];
  QuizList.forEach(
      (element) => QuizContentList.add(QuestionCard(quiz: element)));
  return Stack(children: [
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
                    debugPrint('Countdown Ended');
                    setState() {
                      _currentPage++;
                    };

                    if (_pageController.page != QuizContentList.length - 1) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeInOut);

                      _countDownController.restart(duration: _duration);
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: ((context) => QuizSuccessScreen(score: 100))));                      _countDownController.pause();
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Question",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
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
            print(_pageController.page);
            setState() {
              _currentPage++;
            };

            if (_pageController.page != QuizContentList.length - 1) {
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut);

              _countDownController.restart(duration: _duration);
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: ((context) => QuizSuccessScreen(score: 100))));                      _countDownController.pause();
            }
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
  ]);
}