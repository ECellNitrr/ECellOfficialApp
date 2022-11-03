import 'package:ecellapp/models/questions.dart';
import 'package:flutter/material.dart';

import 'option_card.dart';

class QuestionCard extends StatelessWidget {
  final Questions? quiz;
  QuestionCard({Key? key, this.quiz}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(children: [
        Center(
          child: Container(
              margin: EdgeInsets.fromLTRB(5, 15, 5, 15),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                width: 2,
                color: Colors.yellowAccent,
              )),
              child: Center(
                child: Column(children: [
                  Text((quiz?.question).toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  quiz!.isImage==true? Container(
                    height: 100,
                    child:ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: quiz!.images?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.all(5),
                          height: 50,
                          child: Image.network(
                        quiz!.images![index],
                          fit: BoxFit.fill,
                        ),
                        );
                      }
                      ))
              : SizedBox(
                          height: 30,
                        ),
                ]),
              )),
        ),
        Options(height: height, width: width, option: quiz!.answers![0]),
        Options(height: height, width: width, option: quiz!.answers![1]),
        Options(height: height, width: width, option: quiz!.answers![2]),
        Options(height: height, width: width, option: quiz!.answers![3]),
      ]),
    );
  }
}