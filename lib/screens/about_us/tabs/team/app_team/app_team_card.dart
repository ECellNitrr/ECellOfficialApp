import 'package:flutter/material.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../models/sponsor_head.dart';

const List<dynamic> appTeam=[
  {
    "name": "Vasu soni",
    "image": "https://ecellbackend.tech/media/static/uploads/team/image_-_Vasu_Soni_vIDBlLh.jpg",
    "member_type": "HCO",
    "linkedin": "https://www.linkedin.com/in/iamvasusoni",
    "phone" :"9109691805",
    "email": "write2treav@gmail.com",
  },
  {
    "name": "Kumar Utsav",
    "image": S.assetEcellLogoWhite,
    "member_type": "EXC",
    "domain": "tech",
    "linkedin": "https://www.linkedin.com/in/kumar-utsav-flutdev/",
    "phone" :"7250241229",
    "email": "utsavkumar.9749@gmail.com"
  },
  {
    "name": "Neeraj Yadu",
    "image": S.assetEcellLogoWhite,
    "member_type": "EXC",
    "domain": "tech",
    "linkedin": "https://www.linkedin.com/in/neeraj-yadu-9b7a8a22a/",
    "phone" :"8770904101",
    "email": "fdfgfdfdfg"
  },
  {
    "name": "K Venkat Nag Sai",
    "image": S.assetEcellLogoWhite,
    "member_type": "EXC",
    "year": 2022,
    "domain": "tech",
    "linkedin": "https://www.linkedin.com/in/k-venkat-nag-sai-354128232/",
    "phone" :"7000469397",
    "email": "kjjjhghg"
  }
];

class AppHead {
  String? type;
  String? name;
  String? phone;
  String? email;
  String? linkedin;
  String? image;

  AppHead(dynamic ele)
  {
    this.type=ele["memeber_type"];
    this.name=ele["name"];
    this.phone=ele["phone"];
    this.email=ele["email"];
    this.linkedin=ele["linkedin"];
    this.image=ele["image"];
  }

}

class AppTeamCard extends StatelessWidget {
  final AppHead? appHead;

  const AppTeamCard({Key? key, this.appHead}) : super(key: key);

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
                    appHead!.name!,
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
                                WidgetSpan(child: Icon(Icons.phone,size: 16,color: C.blendSocialIconColorTwo,)),
                                TextSpan(text: appHead!.phone!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: C.cardFontColor,
                                    fontWeight: FontWeight.w600,
                                  ),)
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
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            //Handle sponsor.spons[0].socialMedia
                            if (await canLaunchUrlString(appHead!.linkedin!)) {
                              await launchUrlString(appHead!.linkedin!);
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
                        TextSpan(text: appHead!.email!,
                          style: TextStyle(
                            fontSize: 18,
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
                          child: Image.network(appHead!.image!,
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

class AppTeamList{
  List<AppTeamCard> createTeamList(){
    List<AppTeamCard> appTeamList = List.empty(growable: true);
    appTeam.forEach((element){
      AppHead appHead=AppHead(element);
      appTeamList.add(AppTeamCard(appHead: appHead,));
    });
    return appTeamList;
  }
}
