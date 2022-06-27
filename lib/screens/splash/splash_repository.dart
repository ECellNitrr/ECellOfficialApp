import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/res/errors.dart';
import '../../core/res/strings.dart';
import '../../core/utils/injection.dart';
import '../../core/utils/logger.dart';
import '../../models/user.dart';

@immutable
abstract class SplashRepository {
  /// Fetches `Token` from Shared Preferences , gives the user details and throws a suitable exception if something goes wrong.
  Future<User> getProfile();
}

class FakeSplashRepository extends SplashRepository {
  @override
  Future<User> getProfile() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    if (Random().nextBool()) {
      // random network error
      throw NetworkException();
    } else {
      var response = {
        S.firstnameKey: "Sahil",
        S.lastnameKey: "Silare",
        S.emailKey: "sahil@gmail.com",
        S.phoneKey: "9999999999",
      };

      // fake successful response (the data entered here same as in the API Doc example)
      return User.fromJson(response);
    }
  }
}

class APISplashRepository extends SplashRepository {
  final String classTag = "APISplashRepository";
  @override
  Future<User> getProfile() async {
    final SharedPreferences sharedPreferences = sl.get<SharedPreferences>();
    String token = sharedPreferences.getString(S.tokenKeySharedPreferences);
    final String tag = classTag + "getUserDetails";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get(S.getUserDetailsUrl, headers: <String, String>{
        "Authorization": "$token",
      });
    } catch (e) {
      throw NetworkException();
    }

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw ValidationException(response.body);
    } else {
      Log.s(
          tag: tag,
          message: "Unknown response code -> ${response.statusCode}, message ->" + response.body);
      throw UnknownException();
    }
  }
}
