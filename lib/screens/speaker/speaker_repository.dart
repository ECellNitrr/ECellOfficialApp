import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/speaker.dart';

@immutable
abstract class SpeakerRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<Speaker>> getAllSpeakers();
}

class FakeSpeakerRepository extends SpeakerRepository {
  @override
  Future<List<Speaker>> getAllSpeakers() async {
    //Network delay here
    await Future.delayed(Duration(seconds: 1));

    //Fake Response and Network Delay
    if (Random().nextBool()) {
      throw NetworkException();
    } else {
      var response = {
        "data": [
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          },
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          },
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          },
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          },
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          },
          {
            "company": "msdnms",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description": "none",
            "email": "ansh_srtv@outlook.com",
            "experience": 2,
            "flag": true,
            "id": 1,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "absan",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "blank",
            "year": 2019
          },
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          },
          {
            "company": "The Logical Indian",
            "contact": "",
            "created_at": "2021-01-13T11:33:00.689210Z",
            "description":
                "The most difficult part of being a journalist is printing something which someone else doesn't want to be printed. In this day where all the media houses run for TRP, Shwetha Kothari is one of those few journalists who stand for nothing else but the absolute truth. Currently the Managing Editor at The Logical Indian, she's extremely vocal on her views on various issues like unsettled public issues, feminism, exploiting India's entrepreneurial potential. With tons of experience on her shoulder, her session can help you find the right direction in life.",
            "email": "shwetakothari@in.com",
            "experience": 2,
            "flag": true,
            "id": 16,
            "modified_at": "2021-01-13T11:43:16.131751Z",
            "name": "Shweta Kothari",
            "profile_pic":
                "https://ichef.bbci.co.uk/news/976/cpsprodpb/7727/production/_103330503_musk3.jpg",
            "social_media": "https://www.linkedin.com/in/shweta-kothari-b57a8453",
            "year": 2019
          }
        ],
        "message": "Speakers Fetched Successfully"
      };

      return (response["data"] as List).map((e) => Speaker.fromJson(e)).toList();
    }
  }
}

class APISpeakerRepository extends SpeakerRepository {
  final String classTag = "APIgetSpeakerRepository";
  @override
  Future<List<Speaker>> getAllSpeakers() async {
    final String tag = classTag + "getAllSpeakers()";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get(S.getSpeakerUrl);
    } catch (e) {
      throw NetworkException();
    }

    if (response.statusCode == 200) {
      var speakerResponse = jsonDecode(response.body);
      return (speakerResponse["data"] as List).map((e) => Speaker.fromJson(e)).toList();
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
