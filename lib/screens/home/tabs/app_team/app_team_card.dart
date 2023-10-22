import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../models/sponsor_head.dart';
import '../../../../widgets/UI2023widgets/HomeScreen.dart';

const Map<int, dynamic> appTeam = {
  2023: [
    {
      "name": "Kumar Utsav",
      "image":
          "https://media.licdn.com/dms/image/C4D03AQEolcSpLuu4bg/profile-displayphoto-shrink_400_400/0/1657438458806?e=1703721600&v=beta&t=RMw_57ya-v5FxDttyx9ntzEfx0d-aK3J6wx2BcmeCIc",
      "member_type": "MNG",
      "domain": "tech",
      "linkedin": "https://www.linkedin.com/in/kumar-utsav-flutdev/",
      "phone": "7250241229",
      "email": "utsavkumar.9749@gmail.com"
    },
    {
      "name": "Neeraj Yadu",
      "image": "https://media.licdn.com/dms/image/C4D03AQHuZ150ESZ1_w/profile-displayphoto-shrink_400_400/0/1658671069104?e=1703721600&v=beta&t=L2VfdaqsRJtgfft-35Y9RnIdjqLwa-fr1dqHKx5waEA",
      "member_type": "MNG",
      "domain": "tech",
      "linkedin": "https://www.linkedin.com/in/neeraj-yadu-9b7a8a22a/",
      "phone": "8770904101",
      "email": "neerajyadu8281@gmail.com"
    },
    {
      "name": "K Venkat Nag Sai",
      "image": "https://media.licdn.com/dms/image/C5603AQFVmSYLVnobOQ/profile-displayphoto-shrink_100_100/0/1644940070285?e=1703721600&v=beta&t=SdsaUzlpvG1IOLegzp0HeLZLYWo_U697hHWa6jDleFg",
      "member_type": "MNG",
      "domain": "tech",
      "linkedin": "https://www.linkedin.com/in/k-venkat-nag-sai-354128232/",
      "phone": "7000469397",
      "email": "k.venkatnagsai@gmail.com"
    },
  ],
  2021: [
    {
      "name": "Vasu soni",
      "image": "https://media.licdn.com/dms/image/C5603AQGZgFREBgW0nQ/profile-displayphoto-shrink_400_400/0/1640242473751?e=1703721600&v=beta&t=FS8sWA463KvFImNoac9nEiTbH1n8JM9VCAZbF5iBbIw",
      "member_type": null,
      "linkedin": "https://www.linkedin.com/in/iamvasusoni",
      "phone": "9109691805",
      "email": "write2treav@gmail.com",
    },
    {
      "name": "Viren Khatri",
      "image": "https://media.licdn.com/dms/image/D4D03AQFeue6zKpkdwA/profile-displayphoto-shrink_400_400/0/1668967183090?e=1703721600&v=beta&t=iie4GAozQauZFJL9YeU7nem7Y6FzVQAmDLdnFOTQnXs",
      "linkedin": "https://www.linkedin.com/in/werainkhatri/",
      "phone": null,
      "email": null,
      "member_type": null,
    },
    {
      "name": "Siddharth Mishra",
      "image": "https://media.licdn.com/dms/image/D4D03AQEgsacbW0qlLQ/profile-displayphoto-shrink_400_400/0/1671455889879?e=1703721600&v=beta&t=ztLErOpmUKjn3lMx3tWEbRTy5kI-VIxf-leMESilnyU",
      "linkedin": "https://www.linkedin.com/in/smishra1605/",
      "phone": null,
      "email": null,
      "member_type": null,
    },
    {
      "name": "Divy Arpit",
      "image": "https://media.licdn.com/dms/image/C5103AQFO88bkMmgFEw/profile-displayphoto-shrink_400_400/0/1575970206509?e=1703721600&v=beta&t=KYeHcHTcq8t2ZzQaCfCSv6W_g8-Lm1lUmh-uYEPfANI",
      "linkedin": "https://www.linkedin.com/in/divy-arpit/",
      "phone": null,
      "email": null,
      "member_type": null,
    },
  ]
};

class AppHead {
  String? type;
  String? name;
  String? phone;
  String? email;
  String? linkedin;
  String? image;

  AppHead(dynamic ele) {
    this.type = ele["member_type"];
    this.name = ele["name"];
    this.phone = ele["phone"];
    this.email = ele["email"];
    this.linkedin = ele["linkedin"];
    this.image = ele["image"];
  }
}

class AppTeamCard extends StatelessWidget {
  final AppHead? appHead;
  const AppTeamCard({required this.appHead});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(
                color: C.menuButtonColor.withOpacity(0.3),
                offset: Offset(4, 4),
                blurRadius: 2,
                spreadRadius: -10)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.0)), // Rounded corners
                    image: DecorationImage(
                      image: AssetImage(S.assetSpeakerBackdrop),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [Colors.transparent, Colors.transparent],
                    ),
                  ),
                ),
                Container(
                  height: height * 0.19,
                  width: height * 0.17,
                  child: Center(
                    child: Container(
                      height: height * 0.15,
                      width: height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(20.0)), // Rounded corners
                        image: DecorationImage(
                          image: NetworkImage(appHead!.image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: height * 0.19,
                  width: height * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(20.0)), // Rounded corners
                    image: DecorationImage(
                      image: AssetImage(S.assetTeamProfile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.19,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        SizedBox(
                          height: height * 0.14,
                          width: height * 0.17,
                        ),
                        Container(
                          width: height * 0.25,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  6.0, 15.0, 0.0, 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EventText(
                                    color: Colors.black,
                                    text: appHead!.name!,
                                    maxLines: 1,
                                    size: 24.0,
                                  ),
                                  (appHead!.type != null)
                                      ? EventText(
                                          color: Colors.black,
                                          text: "Tech Manager",
                                          maxLines: 1,
                                          size: 18.0,
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  (appHead!.type != null)
                                      ? EventText(
                                          color: Colors.black,
                                          text: "Contact Us:",
                                          maxLines: 1,
                                          size: 18.0,
                                        )
                                      : Container(),
                                  (appHead!.type != null)
                                      ? Row(
                                          children: [
                                            IconButton(
                                                onPressed: () async {
                                                  String email = Uri.encodeComponent(appHead!.email!);
                                                  String subject = Uri.encodeComponent("Hello Flutter");
                                                  String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
                                                  print(subject); //output: Hello%20Flutter
                                                  Uri uri = Uri.parse("mailto:$email?subject=$subject&body=$body");
                                                  if (await launchUrl(
                                                      uri)) {
                                                  } else {
                                                    throw 'Could not launch $uri';
                                                  }
                                                },
                                                icon: Icon(Icons.email)),
                                            IconButton(
                                                onPressed: () async {
                                                  final url =
                                                      "tel:${appHead!.phone!}";
                                                  if (await canLaunchUrlString(
                                                      url)) {
                                                    await launchUrlString(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                icon: Icon(Icons.call)),
                                            IconButton(
                                                onPressed: () async {
                                                  if (await canLaunchUrlString(
                                                      appHead!.linkedin!)) {
                                                    await launchUrlString(appHead!.linkedin!);
                                                  } else {
                                                    throw 'Could not launch ${appHead!.linkedin!}';
                                                  }
                                                },
                                                icon: Image.asset(
                                                    S.assetLinkedinIconBlack)),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final AppHead? appHead;

  const AppCard({Key? key, this.appHead}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return Container(
      child: Center(
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
                margin: EdgeInsets.only(left: 139, right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appHead!.name!,
                      style: TextStyle(
                        fontSize: 22,
                        color: C.cardFontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        appHead!.phone != null
                            ? Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        WidgetSpan(
                                            child: Icon(
                                          Icons.phone,
                                          size: 16,
                                          color: C.blendSocialIconColorTwo,
                                        )),
                                        TextSpan(
                                          text: appHead!.phone!,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: C.cardFontColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () async {
                                    final url = "tel:${appHead!.phone!}";
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                ),
                              )
                            : Container(
                                child: AutoSizeText(
                                  "Connect on Linkedin: ",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: C.cardFontColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              //Handle sponsor.spons[0].socialMedia
                              if (await canLaunchUrlString(
                                  appHead!.linkedin!)) {
                                await launchUrlString(appHead!.linkedin!);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(S.redirectIntentError)));
                              }
                            },
                            child: Image.asset(
                              S.assetIconLinkdin,
                              height: 21,
                              color: Color.alphaBlend(
                                C.blendSocialIconColorOne,
                                C.blendSocialIconColorTwo,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    appHead!.email != null
                        ? RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                    child: Icon(
                                  Icons.mail,
                                  size: 16,
                                  color: C.blendSocialIconColorTwo,
                                )),
                                WidgetSpan(
                                    child: SizedBox(
                                  width: 3,
                                )),
                                TextSpan(
                                  text: appHead!.email!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: C.cardFontColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
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
                            child: Image.network(
                              appHead!.image!,
                              fit: BoxFit.contain,
                              width: 90,
                              height: 90,
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTeamList {
  List<AppTeamCard> createTeamList(int year) {
    List<AppTeamCard> appTeamList = List.empty(growable: true);
    appTeam[year].forEach((element) {
      AppHead appHead = AppHead(element);
      appTeamList.add(AppTeamCard(
        appHead: appHead,
      ));
    });
    return appTeamList;
  }
}
