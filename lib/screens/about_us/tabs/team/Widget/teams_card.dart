import 'package:ecellapp/models/team.dart';
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';

class TeamsCard extends StatelessWidget {
  final TeamMember teamMember;

  const TeamsCard({Key? key, required this.teamMember}) : super(key: key);
  String name(String? name) {
    if (name == null) throw Exception();
    return  name;
  }
  String provider(String? name) {
    if (name == null) throw Exception();
    return  'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fvector%2Fmale-face-silhouette-or-icon-man-avatar-profile-unknown-or-anonymous-person-vector-gm1087531642-291777526&psig=AOvVaw0ti1J1BhRHO6q07wwREUcx&ust=1666981341781000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCIiJrMeDgfsCFQAAAAAdAAAAABAJ';
  }
  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: D.horizontalPaddingFrame, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Container(
            height: ratio > 0.5 ? 120 : 140,
            margin: EdgeInsets.only(left: 130),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Text(
                name( teamMember.name),
                style: TextStyle(
                  fontSize: 20,
                  color: C.cardFontColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          height: ratio > 0.5 ? 200 : 220,
          width: ratio > 0.5 ? 140 : 160,
          child: Stack(
            children: [
              Image.asset(
                S.assetTeamsFrame,
                fit: BoxFit.cover,
                height: 180,
              ),
              Center(
                heightFactor: 1.75,
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0.0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: (teamMember.profilePic == null)
                        ? AssetImage(S.assetEcellLogoWhite)
                        : NetworkImage(teamMember.profilePic!,) as ImageProvider,
                    radius: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}