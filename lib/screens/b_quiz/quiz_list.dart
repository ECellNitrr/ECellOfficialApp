import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/screens/b_quiz/quiz_repository.dart';
import 'package:ecellapp/screens/b_quiz/quiz_screen.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/res/strings.dart';
import '../../widgets/raisedButton.dart';
import 'cubit/quiz_cubit.dart';

class QuizList extends StatelessWidget {
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
                SizedBox(width: 15),
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
            ListButton(text: 'demo', month: 11, day: 5, startHr: 0, endHr: 24,),
            ListButton(text: 'November 27', month: 11, day: 27, startHr: 0, endHr: 23,),
            ListButton(text: 'November 28', month: 11, day: 28, startHr: 0, endHr: 23,),
            ListButton(text: 'November 29', month: 11, day: 29, startHr: 0, endHr: 23,),
            ListButton(text: 'November 30', month: 11, day: 30, startHr: 0, endHr: 23,),
            ListButton(text: 'December 1', month: 12, day: 1, startHr: 0, endHr: 23,)
          ],
        ),
      ]),
    );
  }
}

class ListButton extends StatelessWidget {

  APIQuizRepository apiQuizRepository =new APIQuizRepository(label: 'demo');
  ListButton({required this.text, required this.month, required this.day, required this.startHr, required this.endHr});
  final String text;

  List<int> dateTime=List.empty();
  final int month;
  final int day;
  final int startHr;
  final int endHr;

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
                  dateTime=getDatetime();
                  (dateTime[0]==month && dateTime[1]==day &&dateTime[2]>startHr && dateTime[2]<endHr)?
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: ((context) => BlocProvider(
                          create: (_) =>
                              QuizCubit(APIQuizRepository(label: text)),
                          child: Quiz())))):
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Wrong Time to Quiz')));;
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

List<int> getDatetime()
{
  var dt= DateTime.now();
  return[dt.month,dt.day,dt.hour];
}