import 'dart:math';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/event.dart';
import 'package:http/http.dart' as http;
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GalleryRepository {
  /// Takes in nothing, gives the events,their details and throws a suitable exception if something goes wrong.
  Future<Map<String, dynamic>> getAllGalleryImages();
}

// class FakeGalleryRepository implements GalleryRepository {
//   @override
//   Future<List<dynamic>> getAllGalleryImages() async {
//     // Simulate network delay
//     await Future.delayed(Duration(seconds: 2));
//
//     if (false) {
//       // random network error
//       throw NetworkException();
//     } else {
//       var json = {
//         "gallery": {
//           "E-Summit'16" : [
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//           ],
//           "E-Summit'17" : [
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//           ],
//           "E-Summit'18" : [
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//           ],
//           "E-Summit'19" : [
//             {
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },{
//               "big": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13a.JPG",
//               "small": "https://ecell.nitrr.ac.in/media/static/gallery_imgs/E-Summit'16/13ab.JPG"
//             },
//           ]
//         }
//       };
//       List<dynamic> gallery = [];
//       (json["gallery"] as List).forEach((e) => gallery.add(e));
//       // fake successful response (the data entered here is same as in the API Doc example)
//       return gallery;
//     }
//   }
// }

class APIGalleryRepository implements GalleryRepository {
  final String classTag = "APIgetAllEventsRepository";
  @override
  Future<Map<String, dynamic>> getAllGalleryImages() async {
    final String tag = classTag + "getAllEvents";
    http.Response response;
    try {
      response = await sl.get<http.Client>().get(
        Uri.parse(S.galleryUrl),
      );
    } catch (e) {
      Log.e(tag: tag, message: "NetworkError:" + e.toString());
      throw NetworkException();
    }

    if (response.statusCode == 200) {
      Log.i(tag: tag, message: "Request Successful");
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      // print(json);
      Map<String, dynamic> galleryImages = {};
      galleryImages = json["gallery"] as Map<String, dynamic>;

      return galleryImages;

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

