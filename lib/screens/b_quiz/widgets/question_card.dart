import 'package:ecellapp/models/questions.dart';
import 'package:flutter/material.dart';

import 'option_card.dart';

class QuestionCard extends StatefulWidget {
  Function callBack;
  final Questions? quiz;
  QuestionCard({Key? key, this.quiz, required this.callBack}) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<bool> isSelected = [false, false, false, false];

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
                  Text((widget.quiz?.question).toString(),
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  widget.quiz!.isImage == true
                      ? Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.quiz!.images?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: EdgeInsets.all(5),
                                  height: 50,
                                  child: Image.network(
                                    widget.quiz!.images![index],
                                    fit: BoxFit.fill,
                                  ),
                                );
                              }))
                      : SizedBox(
                          height: 30,
                        ),
                ]),
              )),
        ),
        ToggleButtons(
          direction: Axis.vertical,
          selectedBorderColor: Colors.lightBlueAccent,
          splashColor:Colors.red[200],
          isSelected: isSelected,
          children: [
            Options(
                height: height, width: width, option: widget.quiz!.answers![0]),
            Options(
                height: height, width: width, option: widget.quiz!.answers![1]),
            Options(
                height: height, width: width, option: widget.quiz!.answers![2]),
            Options(
                height: height, width: width, option: widget.quiz!.answers![3]),
          ],
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < isSelected.length; index++) {
                if (newIndex == index) {
                  isSelected[index] = true;
                  print(isSelected);
                  widget.callBack(newIndex+1,widget.quiz!.correctIndex);
                } else {
                  isSelected[index] = false;
                }
              }
            });
          },
        )
      ]),
    );
  }
}
