import 'package:ecellapp/models/team.dart';
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';

class TeamsCard extends StatelessWidget {
  final TeamMember teamMember;

  const TeamsCard({Key? key, required this.teamMember}) : super(key: key);

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
                teamMember!.name!,
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
                S.assetTeamFrame,
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
                    backgroundImage: (teamMember!.image== null)? AssetImage(S.assetEcellLogoWhite) : NetworkImage(teamMember!.image!) as ImageProvider,
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