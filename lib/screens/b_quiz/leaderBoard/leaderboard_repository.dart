import 'dart:convert';
import 'dart:math';

import 'package:ecellapp/models/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';


@immutable
abstract class LeaderRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<Data>> getAllleaders();
}



class APILeaderRepository extends LeaderRepository {
  final String classTag = "APIgetleaderRepository";
  @override
  Future<List<Data>> getAllleaders() async {
    final String tag = classTag + "getAllleaders()";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get("http://43.205.53.122/bquiz/leaderboard/");
    } catch (e) {
      throw NetworkException();
    }

    if (response.statusCode == 200) {
      var leaderResponse = jsonDecode(response.body);
      return (leaderResponse["data"] as List).map((e) => Data.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw ValidationException(response.body);
    } else {
      Log.s(
          tag: tag,
          message: "Unknown response code -> ${response.statusCode}, message ->" + response.body);
      throw UnknownException();
    }
  }
  
  
}
