import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';


class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double heightFactor = height / 1000;
    return Scaffold(
      body: Stack(children: [
        ScreenBackground(elementId: 0),
        Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.0,),
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
                  SizedBox(width: 20.0,),
                  CircularCountDownTimer(
                    duration: 30,
                    initialDuration: 0,
                    controller: CountDownController(),
                    width: MediaQuery.of(context).size.width / 7,
                    height: MediaQuery.of(context).size.height / 10,
                    ringColor: Colors.grey[300],
                    fillColor: Colors.purpleAccent[100],
                    backgroundColor: Colors.purple[500],
                    strokeWidth: 10.0,
                    strokeCap: StrokeCap.round,
                    textStyle: TextStyle(
                        fontSize: 25.0, color: Colors.white, fontWeight: FontWeight.bold),
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
                    },
                  ),
                ],
              ),
              Container(
                height: height/3.5,
                child: Text("Question",style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),),
              ),
              Options(height: height, width: width,option: "Option#1",),
              Options(height: height, width: width,option: "Option#2"),
              Options(height: height, width: width,option: "Option#3"),
              Options(height: height, width: width,option: "Option#4"),
            ],
          ),
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
            child: FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              color: Colors.transparent,
              onPressed: ()=>print("NACHO"),
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

class Options extends StatelessWidget {
  Options({
    Key key,
    @required this.height,
    @required this.width,
    @required this.option,
  }) : super(key: key);

  final double height;
  final double width;
  String option;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>print("HIT"),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Container(
          height: height/11.5,
          width: width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 25,
                color: C.cardFontColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}