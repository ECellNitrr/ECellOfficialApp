import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecellapp/models/questions.dart';
import 'package:ecellapp/models/quiz_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/cubit/login_cubit.dart';

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
      querySnapshot.docs.forEach((doc){
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
