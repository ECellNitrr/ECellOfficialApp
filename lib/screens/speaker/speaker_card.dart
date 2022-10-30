import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/models/speaker.dart';

class SpeakerCard extends StatelessWidget {
  final Speaker? speaker;

  const SpeakerCard({Key? key, this.speaker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: D.horizontalPaddingFrame),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ExpansionTile(
                    title: Container(
                      height: ratio > 0.5 ? 140 : 160,
                      margin: EdgeInsets.only(left: 130),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            speaker!.name!,
                            style: TextStyle(
                              fontSize: 25,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                          ),
                          SizedBox(height: 5),
                          AutoSizeText(
                            speaker!.company!,
                            style:
                                TextStyle(fontSize: 17, color: C.cardFontColor),
                            maxLines: 4,
                          ),
                          SizedBox(height: 13),
                        ],
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          speaker!.description!,
                          style: TextStyle(color: C.cardFontColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 40,
                  right: 0,
                  bottom: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 45),
                        GestureDetector(
                            onTap: () async {
                              //Handle speaker.socialMedia
                              if (await canLaunchUrl(Uri.parse(speaker!.socialMedia!))) {
                                await launchUrl(Uri.parse(speaker!.socialMedia!));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(S.redirectIntentError)));
                              }
                            },
                            child: Image.asset(
                              S.assetIconLinkdin,
                              height: 20,
                              color: Color.alphaBlend(C.blendSocialIconColorOne,
                                  C.blendSocialIconColorTwo),
                            )),
                      ],
                    ),
                  )),
              Positioned(
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          colors: [
                            Colors.orange,
                            Colors.yellow,
                            Colors.yellow,
                            Colors.white,
                            Colors.white,
                          ],
                        )
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Speaker ${speaker!.year!}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          color: C.cardFontColor,
                          fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          height: ratio > 0.5 ? 200 : 220,
          width: ratio > 0.5 ? 150 : 170,
          child: Stack(
            children: [
              Image.asset(
                S.assetSpeakerCardFrame,
                fit: BoxFit.cover,
                height: 220,
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  backgroundImage: NetworkImage("https://ecellbackend.tech"+speaker!.profilePic!),
                  radius: 45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
