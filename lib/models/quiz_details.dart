// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:ecellapp/core/res/strings.dart';

class QuizDetail extends Equatable {
  final int? date;
  final int? month;
  final int? startTime;
  final int? endTime;
  final String? name;
  
  QuizDetail({
    this.date,
    this.month,
    this.startTime,
    this.endTime,
    this.name,
  });

  

  factory QuizDetail.fromFirestore(
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return QuizDetail(
        date: data["date"],
        month: data["month"],
        startTime: data["startTime"],
        endTime: data["endTime"],
        name: data["name"],);
  }

  @override
  List<Object?> get props => [name];
}
