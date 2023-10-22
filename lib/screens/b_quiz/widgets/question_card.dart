import 'dart:async';

import 'package:ecellapp/models/questions.dart';
import 'package:flutter/material.dart';

import 'option_card.dart';

class QuestionCard extends StatefulWidget {
  Stream<bool> stream;
  Function callBack;
  final Questions? quiz;
  QuestionCard({Key? key, this.quiz, required this.callBack,required this.stream}) : super(key: key);

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  List<bool> isSelected1 = [false];
  List<bool> isSelected2 = [false];
  List<bool> isSelected3 = [false];
  List<bool> isSelected4 = [false];
  Color c= Colors.blueAccent;
  Color fillColor = Colors.blue.shade100;
  @override
  void initState() {
    super.initState();
    widget.stream.listen((flag) {
      mySetState(flag);
     });
  }
  void mySetState(bool flag){
    if(flag==true){
      if(mounted){setState(() {
        c=Colors.green;
        fillColor = Colors.green;
      });}
    }
    else{
      if(mounted){setState(() {
        c=Colors.red;
        fillColor = Colors.red;
      });}
    }

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: height*0.01),
        child: Column(children: [
          Container(
            width: width,
              child: Padding(
                padding: EdgeInsets.all(5),
                
                child: Column(children: [
                  Text((widget.quiz?.question).toString(),
                  textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  widget.quiz!.isImage == true
                      ? Container(
                          height: 100,
                          child: Center(
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
                                }),
                          ))
                      : SizedBox(
                          height: 30,
                        ),
                ]),
              )),
          Container(
            child: Column(
              children: [
                ToggleButtons(
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(22),
                  direction: Axis.vertical,
                  borderColor: Colors.black38,
                  fillColor: fillColor,
                  selectedBorderColor: c,
                  isSelected: isSelected1,
                  children: [
                    Options(
                        height: height, width: width, option: widget.quiz!.answers![0]),
                  ],
                  onPressed: (int newIndex) {
                    setState(() {
                          isSelected1[0] = !isSelected1[0];
                          isSelected2[0] = false;
                          isSelected3[0] = false;
                          isSelected4[0] = false;
                          print(isSelected1);
                          widget.callBack(1,widget.quiz!.correctIndex);
                        
                    });
                  },
                ),
                SizedBox(height: 10,),
                ToggleButtons(
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(22),
                  borderColor: Colors.black38,
                  direction: Axis.vertical,
                  selectedBorderColor: c,
                  fillColor: fillColor,
                  isSelected: isSelected2,
                  children: [
                    Options(
                        height: height, width: width, option: widget.quiz!.answers![1]),
                  ],
                  onPressed: (int newIndex) {
                    setState(() {
                      isSelected2[0] = !isSelected2[0];
                      isSelected1[0] = false;
                      isSelected3[0] = false;
                      isSelected4[0] = false;
                      print(isSelected2);
                      widget.callBack(2, widget.quiz!.correctIndex);
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleButtons(
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(22),
                  borderColor: Colors.black38,
                  direction: Axis.vertical,
                  selectedBorderColor: c,
                  isSelected: isSelected3,
                  fillColor: fillColor,
                  children: [
                    Options(
                        height: height, width: width, option: widget.quiz!.answers![2]),
                  ],
                  onPressed: (int newIndex) {
                    setState(() {
                      isSelected3[0] = !isSelected3[0];
                      isSelected1[0] = false;
                      isSelected2[0] = false;
                      isSelected4[0] = false;
                      print(isSelected3);
                      widget.callBack(3, widget.quiz!.correctIndex);
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ToggleButtons(
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(22),
                  borderColor: Colors.black38,
                  direction: Axis.vertical,
                  selectedBorderColor: c,
                  fillColor: fillColor,
                  isSelected: isSelected4,
                  children: [
                    Options(
                        height: height, width: width, option: widget.quiz!.answers![3]),
                  ],
                 onPressed: (int newIndex) {
                    setState(() {
                      isSelected4[0] = !isSelected4[0];
                      isSelected1[0] = false;
                      isSelected3[0] = false;
                      isSelected2[0] = false;
                      print(isSelected4);
                      widget.callBack(4, widget.quiz!.correctIndex);
                    });
                  },
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
