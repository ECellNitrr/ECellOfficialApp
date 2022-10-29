import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

class Questions {
  String? question;
  List<String>? answers;
  int? correctIndex;
  List<String>? images;

  Questions({this.question, this.answers, this.correctIndex, this.images});

  factory Questions.fromJson(Map<String, dynamic> json) => Questions(
        question: json["question"],
        answers: List<String>.from(json["answers"].map((x) => x)),
        correctIndex: json["correctIndex"],
        images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    );

  @override
  List<Object> get props => throw UnimplementedError();
  
}