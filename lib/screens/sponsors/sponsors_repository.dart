import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';

import '../../core/res/errors.dart';
import '../../models/sponsor.dart';
import '../../models/sponsor_category.dart';

@immutable
abstract class SponsorsRepository {
  /// All subfunctions are final No arguments required returns json
  Future<List<SponsorCategory>> getAllSponsors();
}

class FakeSponsorsRepository extends SponsorsRepository {
  @override
  Future<List<SponsorCategory>> getAllSponsors() async {
    //Network delay here
    await Future.delayed(Duration(seconds: 1));

    //Fake Response and Network Delay
    if (Random().nextBool()) {
      throw NetworkException();
    } else {
      Map<String, dynamic> response = {
        "data": {
          "Title": [
            {
              "id": 3,
              "name": "Anopchand Tilokchand Jewellers",
              "details": "Title Sponsors",
              "pic": "/media/static/uploads/sponsors/download.jpeg",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://atjewel.com/",
              "spons_type": "Title",
              "importance": 200,
              "category_importance": 10,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ],
          "Partner": [
            {
              "id": 5,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ],
          "XYZ": [
            {
              "id": 6,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            },
            {
              "id": 7,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            },
            {
              "id": 8,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            },
            {
              "id": 9,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            },
            {
              "id": 10,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ],
          "AAAA": [
            {
              "id": 5,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ],
          "BBBB": [
            {
              "id": 5,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ],
          "CCCC": [
            {
              "id": 5,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ],
          "DDDD": [
            {
              "id": 5,
              "name": "Happy Chases",
              "details": "Digital Media Partner",
              "pic": "/media/static/uploads/sponsors/happychases.png",
              "pic_url": "https://via.placeholder.com/150",
              "contact": "",
              "website": "https://www.happychases.com/",
              "spons_type": "Partner",
              "importance": 83,
              "category_importance": 6,
              "year": 2019,
              "flag": true,
              "ecell_user": null
            }
          ]
        },
        "message": "fetched successfully",
        "spons_categories": ["Title", "Partner", "XYZ", "AAAA", "BBBB", "CCCC", "DDDD"]
      };

      List<SponsorCategory> sponsorData = List();

      // iterating through a list of sponsor category names
      response["spons_categories"].forEach((e) {
        // for each category name, creating a list of sponsors belonging to that category
        List<Sponsor> sponsors = List();
        // iterating through the list of sponsor data that belong to that category
        // and for each one of them, converting them from map into Sponsor model
        // and adding to the sponsors list.
        response["data"][e].forEach((e) => sponsors.add(Sponsor.fromJson(e)));
        // creating a SponsorCategory, and adding it to the sponsorData
        sponsorData.add(SponsorCategory(e, sponsors));
      });

      return sponsorData;
    }
  }
}

class APISponsorsRepository extends SponsorsRepository {
  final String classTag = "APISponsorsRepository";

  @override
  Future<List<SponsorCategory>> getAllSponsors() async {
    final String tag = classTag + "getAllSponsors()";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get(S.getSponsorsUrl);
    } catch (e) {
      throw NetworkException();
    }
    if (response.statusCode == 200) {
      //Process response here
      Map<String, dynamic> sponsorResponse = jsonDecode(response.body);
      List<SponsorCategory> sponsorData = List();
      sponsorResponse["spons_categories"].forEach((e) {
        List<Sponsor> sponsors = List();
        sponsorResponse["data"][e].forEach((e) => sponsors.add(Sponsor.fromJson(e)));
        sponsorData.add(SponsorCategory(e, sponsors));
      });
      return sponsorData;
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
