import 'package:flutter/material.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/sponsor_head.dart';

class SponsorHeadCard extends StatelessWidget {
  final SponsorHead? sponsorHead;

  const SponsorHeadCard({Key? key, this.sponsorHead}) : super(key: key);

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
              margin: EdgeInsets.only(left: 139,right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sponsorHead!.name!,
                    style: TextStyle(
                      fontSize: 25,
                      color: C.cardFontColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 7,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(child: Icon(Icons.phone,size: 17,color: C.blendSocialIconColorTwo,)),
                                TextSpan(text: sponsorHead!.phone!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: C.cardFontColor,
                                    fontWeight: FontWeight.w600,
                                  ),)
                              ],
                            ),
                          ),
                          onTap: () async {
                            final url = "tel:${sponsorHead!.phone!}";
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            //Handle sponsor.spons[0].socialMedia
                            if (await canLaunchUrlString(sponsorHead!.linkedin!)) {
                              await launchUrlString(sponsorHead!.linkedin!);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(S.redirectIntentError)));
                            }
                          },
                          child: Image.asset(
                            S.assetIconLinkdin,
                            height: 25,
                            color: Color.alphaBlend(
                              C.blendSocialIconColorOne,
                              C.blendSocialIconColorTwo,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(child: Icon(Icons.mail,size: 16,color: C.blendSocialIconColorTwo,)),
                        WidgetSpan(child: SizedBox(width: 3,)),
                        TextSpan(text: sponsorHead!.email!,
                          style: TextStyle(
                            fontSize: 10,
                            color: C.cardFontColor,
                            fontWeight: FontWeight.w600,
                          ),)
                      ],
                    ),
                  ),
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
                          child: Image.network(sponsorHead!.profilePic!,
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
