import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/res/errors.dart';
import '../../core/res/strings.dart';
import '../../core/utils/injection.dart';
import '../../core/utils/logger.dart';

@immutable
abstract class HomeRepository {
  /// Posts the feedback as submitted by the user and throws a suitable exception if something goes wrong.
  Future<void> postFeedback(String feedback);
}

class FakeHomeRepository extends HomeRepository {
  @override
  Future<void> postFeedback(String feedback) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    if (Random().nextBool()) {
      // random network error
      throw NetworkException();
    } else {
      // fake successfull operation
      return;
    }
  }
}

class APIHomeRepository extends HomeRepository {
  final String classTag = "APIHomeRepository";

  @override
  Future<void> postFeedback(String feedback) async {
    final SharedPreferences sharedPreferences = sl.get<SharedPreferences>();
    String name = sharedPreferences.getString(S.nameKeySharedPreferences);
    String email = sharedPreferences.getString(S.emailKeySharedPreferences);
    final String tag = classTag + "postFeedback";
    http.Response response;
    try {
      response = await sl.get<http.Client>().post(
        S.postFeedbackUrl,
        body: <String, dynamic>{
          S.feedbackNameKey: name,
          S.emailKey: email,
          S.feedbackMessageKey: feedback
        },
      );
    } catch (e) {
      Log.e(tag: tag, message: "NetworkError:" + e.toString());
      throw NetworkException();
    }

    if (response.statusCode == 201) {
      Log.i(tag: tag, message: "Feedback Posted Successfully");
      return true;
    } else if (response.statusCode == 400) {
      throw ValidationException(response.body);
    } else {
      Log.s(
          tag: tag,
          message: "Unknown response code -> ${response.statusCode}, message ->" + response.body);
      throw UnknownException();
    }
  }
}
