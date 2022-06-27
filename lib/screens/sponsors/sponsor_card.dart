import 'package:ecellapp/models/sponsor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';

class SponsorCard extends StatelessWidget {
  final Sponsor sponsor;

  const SponsorCard({Key key, this.sponsor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return Container(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: D.horizontalPaddingFrame, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Container(
              height: ratio > 0.5 ? 140 : 160,
              margin: EdgeInsets.only(left: 130),
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
                      sponsor.name,
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
                        if (await canLaunch(sponsor.website)) {
                          await launch(sponsor.website);
                        } else {
                          Scaffold.of(context)
                              .showSnackBar(SnackBar(content: Text(S.redirectIntentError)));
                        }
                      },
                      child: Image.asset(
                        S.assetSponsorGlobeIcon,
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
            height: ratio > 0.5 ? 200 : 220,
            width: ratio > 0.5 ? 150 : 170,
            child: Stack(
              children: [
                Image.asset(S.assetSponsorFrame, fit: BoxFit.cover, height: 200),
                Center(
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
                      backgroundImage: NetworkImage(sponsor.picUrl),
                      radius: 40,
                    ),
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
