import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecellapp/models/quiz_details.dart';
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/errors.dart';

@immutable
abstract class QuizDetailRepository {
  Future<List<QuizDetail>> getAllQuizesDetails();
}

class APIQuizDetailRepository extends QuizDetailRepository {
  final List<QuizDetail> quizList = List.empty(growable: true);

  Future<List<QuizDetail>> getAllQuizesDetails() async {
    final db = FirebaseFirestore.instance;

    try {
      var querySnapshot = await db.collection("QUIZ_DETAILS").get();
      querySnapshot.docs.forEach((doc) {
        quizList.add(QuizDetail.fromFirestore(doc));
      });

      return quizList;
    } on FirebaseException catch (e) {
      print(e);
      throw UnknownException();
    } catch (error) {
      print(error);
      throw UnknownException();
    }
  }
}
