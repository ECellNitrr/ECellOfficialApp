
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/models/quiz_details.dart';
import 'package:ecellapp/screens/b_quiz/cubit/quiz_cubit.dart';
import 'package:ecellapp/screens/b_quiz/cubit/quiz_details_cubit.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/leaderboard_repository.dart';
import 'package:ecellapp/screens/b_quiz/quiz_repository.dart';
import 'package:ecellapp/screens/b_quiz/quiz_screen.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/gradient_text.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/raisedButton.dart';

class QuizList extends StatelessWidget {
  

  const QuizList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    var dt = DateTime.now();

    return StatefulWrapper(
      onInit: ()=>_getAllQuizesDetails(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
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
        body: 
          Stack(
            children: [
            ScreenBackground(elementId: 1),
              BlocBuilder<QuizDetailCubit, QuizDetailsState>(
              builder: (context, state) {
                if (state is QuizDetailsInitial)
                  return _buildLoading(context);
                else if (state is QuizDetailsSuccess)
                  return _buildSuccess(context, state.quizDetailsList);
                else if (state is QuizDetailsLoading)
                  return _buildLoading(context);
                else
                  return ReloadOnErrorWidget(() => _getAllQuizesDetails(context));
              }),
            ],
          ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<QuizDetail> quizDetailsList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Padding(
          padding: EdgeInsets.only(top: top + 65),
          child: Column(
            children: <Widget>[
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
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: List.generate(
                          quizDetailsList.length,
                          (index) => ListButton(
                              text: quizDetailsList[index].name!,
                              month: quizDetailsList[index].month!,
                              day: quizDetailsList[index].date!,
                              startHr: quizDetailsList[index].startTime!,
                              endHr: quizDetailsList[index].endTime!))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _getAllQuizesDetails(BuildContext context) {
    final cubit = context.read<QuizDetailCubit>();
    cubit.getQuizDetailsList();
  }
}



class ListButton extends StatelessWidget {
  final String text;
  List<int> dateTime = List.empty();
  final int month;
  final int day;
  final int startHr;
  final int endHr;
  ListButton(
      {required this.text,
      required this.month,
      required this.day,
      required this.startHr,
      required this.endHr});

  @override
  Widget build(BuildContext context) {
    APILeaderRepository apiLeaderRepository =
        new APILeaderRepository(label: text);
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
                onPressed: () async {
                  bool ans = await apiLeaderRepository.validate();
                  print(ans);
                  
                  try{

                  if (ans) {
                    dateTime = getDatetime();

                    print(dateTime);
                    (dateTime[0] == month &&
                            dateTime[1] == day &&
                            dateTime[2] == startHr &&
                            dateTime[3] <= endHr)
                        ? Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: ((context) => BlocProvider(
                                    create: (_) => QuizCubit(
                                        APIQuizRepository(label: text)),
                                    child: Quiz(label: text,)))))
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Wrong Time to Quiz')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('You already played the quiz')));
                  }
                  }catch(e){
                    print("Context Error");
                  }
                  
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
                      fontSize: 20,
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

List<int> getDatetime() {
  var dt = DateTime.now();
  return [dt.month, dt.day, dt.hour,dt.minute];

}
