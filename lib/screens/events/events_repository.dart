import 'dart:math';
import 'dart:convert';

import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:flutter/material.dart';

@immutable
abstract class EventsRepository {
  /// Takes in nothing, gives the events,their details and throws a suitable exception if something goes wrong.
  Future<List<Event>> getAllEvents();
}

class FakeEventsRepository implements EventsRepository {
  @override
  Future<List<Event>> getAllEvents() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    if (Random().nextBool()) {
      // random network error
      throw NetworkException();
    } else {
      var json = {
        "message": "Events Fetched successfully.",
        "data": [
          {
            "id": 2,
            "name": "E-Cell",
            "venue": "Audi Hall",
            "date": "2020-09-29T15:21:48.828+00:00",
            "time": "test_time",
            "details":
                "A very detailed text which is very detailed so much that it cannot be more detailed",
            "details_html": "test.html",
            "cover_pic":
                "https://static.businessworld.in/article/article_extra_large_image/1610638130_Zle1Cn_CES_2021.jpg",
            "icon":
                "https://static.businessworld.in/article/article_extra_large_image/1610638130_Zle1Cn_CES_2021.jpg",
            "email": "test@email.com",
            "flag": true,
            "year": 2019,
            "ecell_user": 4,
            "created_at": "2020-09-29T15:21:48.828+00:00",
            "modified_at": "2020-09-29T15:21:48.828+00:00"
          },
          {
            "id": 3,
            "name": "Aavartan",
            "venue": "Amul Parlor",
            "date": "2020-09-29T15:21:48.828+00:00",
            "time": "test_time",
            "details":
                "A very detailed text which is very detailed so much that it cannot be more detailed",
            "details_html": "test.html",
            "cover_pic":
                "https://static.businessworld.in/article/article_extra_large_image/1610638130_Zle1Cn_CES_2021.jpg",
            "icon":
                "https://static.businessworld.in/article/article_extra_large_image/1610638130_Zle1Cn_CES_2021.jpg",
            "email": "test@email.com",
            "flag": true,
            "year": 2019,
            "ecell_user": 4,
            "created_at": "2020-09-29T15:21:48.828+00:00",
            "modified_at": "2020-09-29T15:21:48.828+00:00"
          },
          {
            "id": 0,
            "name": "test",
            "venue": "test_venue",
            "date": "2020-09-29T15:21:48.828+00:00",
            "time": "test_time",
            "details": "test_details",
            "details_html": "test.html",
            "cover_pic":
                "https://static.businessworld.in/article/article_extra_large_image/1610638130_Zle1Cn_CES_2021.jpg",
            "icon":
                "https://static.businessworld.in/article/article_extra_large_image/1610638130_Zle1Cn_CES_2021.jpg",
            "email": "test@email.com",
            "flag": true,
            "year": 2019,
            "ecell_user": 3,
            "created_at": "2020-09-29T15:21:48.828+00:00",
            "modified_at": "2020-09-29T15:21:48.828+00:00"
          }
        ]
      };
      List<Event> events = List();
      (json["data"] as List).forEach((e) => events.add(Event.fromJson(e)));
      // fake successful response (the data entered here is same as in the API Doc example)
      return events;
    }
  }
}

class APIEventsRepository implements EventsRepository {
  final String classTag = "APIgetAllEventsRepository";
  @override
  Future<List<Event>> getAllEvents() async {
    final String tag = classTag + "getAllEvents";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get(
            S.getEventsUrl,
          );
    } catch (e) {
      Log.e(tag: tag, message: "NetworkError:" + e.toString());
      throw NetworkException();
    }

    if (response.statusCode == 200) {
      Log.i(tag: tag, message: "Request Successful");
      var json = jsonDecode(response.body);
      List<Event> events = List();
      (json["data"] as List).forEach((e) => events.add(Event.fromJson(e)));
      return events;
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
