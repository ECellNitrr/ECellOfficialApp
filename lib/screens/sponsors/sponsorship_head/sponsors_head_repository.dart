import 'dart:convert';
import 'dart:math';

import 'package:ecellapp/models/sponsor_head.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';

import '../../../core/res/errors.dart';

@immutable
abstract class SponsorsHeadRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<SponsorHead>> getAllSponsorsHead();
}

class APISponsorsHeadRepository extends SponsorsHeadRepository {
  final String classTag = "APISponsorsRepository";

  @override
  Future<List<SponsorHead>> getAllSponsorsHead() async {
    final String tag = classTag + "getAllSponsors()";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get(Uri.parse(S.getTeamUrl));
    } catch (e) {
      throw NetworkException();
    }
    if (response.statusCode == 200) {
      //Process response here
      Map<String, dynamic> sponsorHeadResponse = jsonDecode(response.body);
      List<SponsorHead> sponsorHead = List.empty(growable: true);
      List<dynamic> data= List.empty(growable: true);
      sponsorHeadResponse['data'].forEach((elem){
        if(elem['member_type']=='HCO' && elem['domain']=='spons'){
          data.add(elem);
        }
      });
      print(data);
      data.forEach((e) {
        print(e);
        sponsorHead.add(SponsorHead.fromJson(e));
      });

      return sponsorHead;
    } else if (response.statusCode == 404) {
      throw ValidationException(response.body);
    } else {
      Log.s(
          tag: tag,
          message:
              "Unknown response code -> ${response.statusCode}, message ->" +
                  response.body);
      throw UnknownException();
    }
  }
}
