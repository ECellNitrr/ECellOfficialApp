import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecellapp/models/questions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/cubit/login_cubit.dart';

@immutable
abstract class QuizRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<Questions>> getAllQuizes();
}

//
// class FakeQuizRepository extends QuizRepository {
//   Future<List<Questions>> getAllQuizes() async {
//     // network delay
//     await Future.delayed(Duration(seconds: 1));
//     if (Random().nextBool()) {
//       throw NetworkException();
//     } else {
//       var response = {
//         "message": "Quiz Fetched successfully.",
//         "questions": [
//           {
//             "question":
//                 "Give the proper name of this 1932 invention that this social psychologist made which has now become the industry standard way of quickly gauging people's thoughts or opinion about items or issues; finding its use in personality tests in colleges as well.Give the proper name of this 1932 invention that this social psychologist made which has now become the industry standard way of quickly gauging people's thoughts or opinion about items or issues; finding its use in personality tests in colleges as well.",
//             "answers": ["Apis", "Coleoptera", "Formicidae", "Rhopalocera"],
//             "correctIndex": 3,
//             "isImage":false,
//             "images": null,
//           },
//           {
//             "question": "How hot is the surface of the sun?",
//             "answers": ["1,233 K", "5,778 K", "12,130 K", "101,300 K"],
//             "correctIndex": 1,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "Who are the actors in The Internship?",
//             "answers": [
//               "Ben Stiller, Jonah Hill",
//               "Courteney Cox, Matt LeBlanc",
//               "Kaley Cuoco, Jim Parsons",
//               "Vince Vaughn, Owen Wilson"
//             ],
//             "correctIndex": 3,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "What is the capital of Spain?",
//             "answers": ["Berlin", "Buenos Aires", "Madrid", "San Juan"],
//             "correctIndex": 2,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question":
//                 "What are the school colors of the University of Texas at Austin?",
//             "answers": [
//               "Black, Red",
//               "Blue, Orange",
//               "White, Burnt Orange",
//               "White, Old gold, Gold"
//             ],
//             "correctIndex": 2,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "What is 70 degrees Fahrenheit in Celsius?",
//             "answers": ["18.8889", "20", "21.1111", "158"],
//             "correctIndex": 2,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "When was Mahatma Gandhi born?",
//             "answers": [
//               "October 2, 1869",
//               "December 15, 1872",
//               "July 18, 1918",
//               "January 15, 1929"
//             ],
//             "correctIndex": 0,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "How far is the moon from Earth?",
//             "answers": [
//               "7,918 miles (12,742 km)",
//               "86,881 miles (139,822 km)",
//               "238,400 miles (384,400 km)",
//               "35,980,000 miles (57,910,000 km)"
//             ],
//             "correctIndex": 2,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "What is 65 times 52?",
//             "answers": ["117", "3120", "3380", "3520"],
//             "correctIndex": 2,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "How tall is Mount Everest?",
//             "answers": [
//               "6,683 ft (2,037 m)",
//               "7,918 ft (2,413 m)",
//               "19,341 ft (5,895 m)",
//               "29,029 ft (8,847 m)"
//             ],
//             "correctIndex": 3,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "When did The Avengers come out?",
//             "answers": [
//               "May 2, 2008",
//               "May 4, 2012",
//               "May 3, 2013",
//               "April 4, 2014"
//             ],
//             "correctIndex": 1,
//             "isImage":true,
//             "images": [
//               "https://source.unsplash.com/random/?Cryptocurrency/",
//               "https://source.unsplash.com/random/?business/",
//               "https://source.unsplash.com/random/?food/"
//             ]
//           },
//           {
//             "question": "What is 48,879 in hexidecimal?",
//             "answers": ["0x18C1", "0xBEEF", "0xDEAD", "0x12D591"],
//             "correctIndex": 1,
//             "isImage":false,
//             "images": null,
//           }
//         ]
//       };
//
//       return (response["questions"] as List)
//           .map((e) => Questions.fromJson(e))
//           .toList();
//     }
//   }
// }
//

class APIQuizRepository extends QuizRepository {
  final String classTag = "APIgetQuizRepository";
  final List<Questions> questionList = List.empty(growable: true);

  final String label;
  APIQuizRepository({required this.label});

  Future<List<Questions>> getAllQuizes() async {
    final db = FirebaseFirestore.instance;

    try {
      print(label);
      await db.collection('QUIZES').doc(label).get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          print(data);
          data.forEach((e, v) => questionList.add(Questions.fromFirestore(v)));
          print(questionList[0].question);
        },
        onError: (e) => print("Error getting document: $e"),
      );
      return questionList;
    } on FirebaseException catch (e) {
      print(e);
      throw UnknownException();
    } catch (error) {
      print(error);
      throw UnknownException();
    }
  }

  
    
}
