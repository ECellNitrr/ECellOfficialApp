import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecellapp/models/sponsor.dart';
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SponsorCard extends StatelessWidget {
  final Sponsor? sponsor;

  const SponsorCard({Key? key, this.sponsor}) : super(key: key);

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
              margin: EdgeInsets.only(left: 137),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: AutoSizeText(
                      sponsor!.name!,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        //Handle sponsor.spons[0].socialMedia
                        if (await canLaunchUrlString(sponsor!.website!)) {
                          await launchUrlString(sponsor!.website!);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(S.redirectIntentError)));
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
                Image.asset(S.assetSponsorFrame,
                    fit: BoxFit.cover, height: 220),
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
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: Offset(0.0, 5),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Image.network(sponsor!.picUrl!,
                          fit: BoxFit.contain,
                        width: 90,
                        height: 90,)
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
