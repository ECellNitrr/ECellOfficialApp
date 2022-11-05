
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../models/team.dart';

class TeamsCard extends StatelessWidget {
  final TeamMember? teamMember;

  const TeamsCard({Key? key, this.teamMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return Container(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: D.horizontalPaddingFrame, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              height: ratio > 0.5 ? 150 : 170,
              margin: EdgeInsets.only(left: 139),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      teamMember!.name!,
                      style: TextStyle(
                        fontSize: 20,
                        color: C.cardFontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        //Handle sponsor.spons[0].socialMedia
                        if (await canLaunchUrlString(teamMember!.linkedin!)) {
                          await launchUrlString(teamMember!.linkedin!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(S.redirectIntentError)));
                        }
                      },
                      child: Image.asset(
                        S.assetIconLinkdin,
                        height: 20,
                        color: Color.alphaBlend(
                          C.blendSocialIconColorOne,
                          C.blendSocialIconColorTwo,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            height: ratio > 0.5 ? 200 : 230,
            width: ratio > 0.5 ? 150 : 170,
            child: Stack(
              children: [
                Image.asset(S.assetTeamFrame,
                    fit: BoxFit.cover, height: 230),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 100,
                          width: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
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
                            backgroundImage: (teamMember!.image== null)
                                ? AssetImage(S.assetEcellLogoWhite)
                                : NetworkImage(teamMember!.image!) as ImageProvider,
                            radius: 40,
                          ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
