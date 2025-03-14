import 'dart:convert';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/team.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:http/http.dart' as http;

import '../../../../core/res/strings.dart';

abstract class TeamRepositoryNew {
  /// fetches all team members data and returns the list of [TeamCategory]
  ///
  /// Make sure that the category that has no members should not be shown in the UI.
  Future<List<TeamCategory>> getAllTeamMembers();
}

// class FakeTeamRepositoryNew implements TeamRepositoryNew {
//   @override
//   Future<List<TeamCategory>> getAllTeamMembers() async {
//     // network delay
//     await Future.delayed(Duration(seconds: 1));
//     if (Random().nextBool()) {
//       throw NetworkException();
//     } else {
//       var response = {
//         "message": "Team members Fetched successfully.",
//         "data": [
//           {
//             "id": 1,
//             "name": "Kick Buttowski",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "EXC",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 2,
//             "name": "Elon Musk",
//             "profile_url":
//             "https://upload.wikimedia.org/wikipedia/commons/8/85/Elon_Musk_Royal_Society_%28crop1%29.jpg",
//             "image": null,
//             "member_type": "HCD",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": null,
//             "facebook": null
//           },
//           {
//             "id": 4,
//             "name": "Bowjack",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "EXC",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 5,
//             "name": "Agent P",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "DIR",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 6,
//             "name": "Jack Sparrow",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "FCT",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 7,
//             "name": "Taylor Swift",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "HCO",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 8,
//             "name": "Pidgeot",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "EXC",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 9,
//             "name": "Dragonite",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "DIR",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 10,
//             "name": "Kiterestu",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "MNG",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 15,
//             "name": "Kochikame",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "MNG",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 11,
//             "name": "Hattori",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "OCO",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//           {
//             "id": 1,
//             "name": "Kazama",
//             "profile_url":
//             "https://i.pinimg.com/originals/83/f5/88/83f588b8414b1bacfd0ef3027b5aba7f.jpg",
//             "image": null,
//             "member_type": "EXC",
//             "year": 2021,
//             "domain": "tech",
//             "linkedin": "http://linkdin.com/IamBttowski",
//             "facebook": "http://facebook.com/IamBttowski"
//           },
//         ]
//       };

//       List<TeamCategory> categories = [
//         TeamCategory("Director", []),
//         TeamCategory("Head of CDC", []),
//         TeamCategory("Faculty Incharge", []),
//         TeamCategory("Overall Co-ordinators", []),
//         TeamCategory("Head Co-ordinators", []),
//         TeamCategory("Managers", []),
//         TeamCategory("Executives", []),
//         TeamCategory("Other", []),
//       ];

//       Map<String, int> typeToIndex = {
//         "DIR": 0,
//         "HCD": 1,
//         "FCT": 2,
//         "OCO": 3,
//         "HCO": 4,
//         "MNG": 5,
//         "EXC": 6,
//       };

//       (response["data"] as List).forEach((e) {
//         // converting json to dart TeamMember object.
//         TeamMember member = TeamMember.fromJson(e);
//         // adding the team member to the specific category.
//         // If that category doesnot exist in our directory, add it to the others list.
//         categories[typeToIndex[member.type] ?? 7].members.add(member);
//       });

//       return categories;
//     }
//   }
// }

class APITeamRepositoryNew extends TeamRepositoryNew {
  final String classTag = "APITeamRepositoryNew";
  TeamMember director = TeamMember(
    name: "Dr. N V Ramana Rao",
    profilePic: "https://cdc.nitrr.ac.in/images/team/director/director.jpg",
    type: "DIR",
    image: "https://cdc.nitrr.ac.in/images/team/director/director.jpg",
    linkedin: null,
    facebook: null,
    domain: null,
  );
  TeamMember cdcHead = TeamMember(
    name: "Dr. Samir Bajpai",
    profilePic: "https://cdc.nitrr.ac.in/tpohead.jpghttps://cdc.nitrr.ac.in/tpohead.jpg",
    type: "HCD",
    image: "https://cdc.nitrr.ac.in/tpohead.jpg",
    linkedin: null,
    facebook: null,
    domain: null,
  );
  TeamMember facultyIncharge = TeamMember(
    name: "Dr. Chandrakant Thakur",
    profilePic: "https://cdc.nitrr.ac.in/images/ckthakur.jpeg",
    type: "FCT",
    image: "https://cdc.nitrr.ac.in/images/ckthakur.jpeg",
    linkedin: null,
    facebook: null,
    domain: null,
  );

  @override
  Future<List<TeamCategory>> getAllTeamMembers() async {
    final String tag = classTag + "getAllTeamMembers()";
    http.Response response;
    try {
      print("Hello");
      response = await sl
          .get<http.Client>()
          .get(Uri.parse(S.getTeamUrl + "${S.teamApiYear}/"));
      print(S.getTeamUrl + "${S.teamApiYear}/");
    } catch (e) {
      throw NetworkException();
    }
    if (response.statusCode == 200) {
      //Process response here

      Map<String, dynamic> teamResponse = jsonDecode(response.body);

      List<TeamCategory> categories = [
        TeamCategory("Director", [director]),
        TeamCategory("Head of CDC", [cdcHead]),
        TeamCategory("Faculty Incharge", [facultyIncharge]),
        TeamCategory("Overall Co-ordinators", []),
        TeamCategory("Head Co-ordinators", []),
        TeamCategory("Technical Team Managers", []),
        TeamCategory("Startup Founder Managers", []),
        TeamCategory("Sponsorship Team Managers", []),
        TeamCategory("Public Relation and Marketing Managers", []),
        TeamCategory("Event Management Managers", []),
        TeamCategory("Documentation Team Managers", []),
        TeamCategory("Design Team Managers", []),
        TeamCategory("Video Editing Executives", []),
        TeamCategory("Technical Team Executives", []),
        TeamCategory("Startup Founder Executives", []),
        TeamCategory("Sponsorship Team Executives", []),
        TeamCategory("Public Relation and Marketing Executives", []),
        TeamCategory("Event Management Executives", []),
        TeamCategory("Documentation Team Executives", []),
        TeamCategory("Design Team Managers", []),
        TeamCategory("Other", []),
      ];

      Map<String, int> typeToIndex = {
        "DIR_": 0,
        "HCD_": 1,
        "FCT_": 2,
        "OCO_": 3,
        "HCO_": 4,
        "MNG_tech": 5,
        "MNG_startup": 6,
        "MNG_spons": 7,
        "MNG_pr": 8,
        "MNG_em": 9,
        "MNG_doc": 10,
        "MNG_design": 11,
        "DIR_videdit": 12,
        "EXC_tech": 13,
        "EXC_startup": 14,
        "EXC_spons": 15,
        "EXC_pr": 16,
        "EXC_em": 17,
        "EXC_doc": 18,
        "EXC_design": 19,
      };
      
      print(teamResponse["data"]);

      (teamResponse["data"] as List).forEach((e) {
        TeamMember member = TeamMember.fromJson(e);
        print(member.domain);
        String category = member.type! + "_";
        if(member.domain !=null && (member.domain!="none")){
          if(member.type != "HCO")
          {
            category+=member.domain!;
          }
        }
        print(category);
        categories[typeToIndex[category] ?? 20].members.add(member);
      });

      return categories;
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
