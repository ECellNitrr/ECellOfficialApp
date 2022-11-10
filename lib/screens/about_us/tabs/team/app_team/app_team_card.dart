import 'package:flutter/material.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../models/sponsor_head.dart';

const Map<int, dynamic> appTeam=
{2022:[
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
    "image": "https://media-exp1.licdn.com/dms/image/C4D03AQEolcSpLuu4bg/profile-displayphoto-shrink_400_400/0/1657438458806?e=1672876800&v=beta&t=hM0TLNZOo-kj-fXJoBF4_3Nfg7XVjgYZoermL0mG27U",
    "member_type": "EXC",
    "domain": "tech",
    "linkedin": "https://www.linkedin.com/in/kumar-utsav-flutdev/",
    "phone" :"7250241229",
    "email": "utsavkumar.9749@gmail.com"
  },
  {
    "name": "Neeraj Yadu",
    "image": "https://media-exp1.licdn.com/dms/image/C4D03AQHuZ150ESZ1_w/profile-displayphoto-shrink_400_400/0/1658671069104?e=1672876800&v=beta&t=51yPLYYvtmPF_8fCGdTtrunD28GAxXgA8ky5kX2uKA0",
    "member_type": "EXC",
    "domain": "tech",
    "linkedin": "https://www.linkedin.com/in/neeraj-yadu-9b7a8a22a/",
    "phone" :"8770904101",
    "email": "neerajyadu8281@gmail.com"
  },
  {
    "name": "K Venkat Nag Sai",
    "image": "https://media-exp1.licdn.com/dms/image/C5603AQFVmSYLVnobOQ/profile-displayphoto-shrink_400_400/0/1644940070285?e=1672876800&v=beta&t=XCRVVXMtTUc7wKqT_29DCWgmHBSk_ehEIRGOLfKr5Ek",
    "member_type": "EXC",
    "year": 2022,
    "domain": "tech",
    "linkedin": "https://www.linkedin.com/in/k-venkat-nag-sai-354128232/",
    "phone" :"7000469397",
    "email": "k.venkatnagsai@gmail.com"
  },
],
  2021:[
    {
      "name": "Viren Khatri",
      "image": "https://media-exp1.licdn.com/dms/image/C4D03AQE_immkTxpvCQ/profile-displayphoto-shrink_400_400/0/1635506619362?e=1673481600&v=beta&t=X8k_X87Xqsl5awLuj1wm1SXuY108RHTWnhAPBON2eOY",
      "linkedin": "https://www.linkedin.com/in/werainkhatri/",
      "phone" :null,
      "email": null,
      "member_type": null,
    },
    {
      "name": "Vasu soni",
      "image": "https://ecellbackend.tech/media/static/uploads/team/image_-_Vasu_Soni_vIDBlLh.jpg",
      "linkedin": "https://www.linkedin.com/in/iamvasusoni",
      "phone" :null,
      "email": null,
      "member_type": null,
    },
    {
      "name": "Siddharth Mishra",
      "image": "https://ecellbackend.tech/media/static/uploads/team/DSC_2789_-_87_Siddharth_Mishra_78k7VM9.JPG",
      "linkedin": "https://www.linkedin.com/in/smishra1605/",
      "phone" :null,
      "email": null,
      "member_type": null,
    },
    {
      "name": "Divy Arpit",
      "image": "https://media-exp1.licdn.com/dms/image/C5103AQFO88bkMmgFEw/profile-displayphoto-shrink_400_400/0/1575970206509?e=1673481600&v=beta&t=OOH6IlPM5HAsPOGA4WV_xdn6naWXqHDEaxHS2-F3V1E",
      "linkedin": "https://www.linkedin.com/in/divy-arpit/",
      "phone" :null,
      "email": null,
      "member_type": null,
    },
  ]};

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
                        fontSize: 23,
                        color: C.cardFontColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 7,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        appHead!.phone!=null
                        ? Expanded(
                          flex: 3,
                          child: GestureDetector(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(child: Icon(Icons.phone,size: 16,color: C.blendSocialIconColorTwo,)),
                                  TextSpan(text: appHead!.phone!,
                                    style: TextStyle(
                                      fontSize: 13,
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
                        )
                        :Container(),
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
                    SizedBox(height: 7,),
                    appHead!.email!=null
                    ?RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.mail,size: 16,color: C.blendSocialIconColorTwo,)),
                          WidgetSpan(child: SizedBox(width: 3,)),
                          TextSpan(text: appHead!.email!,
                            style: TextStyle(
                              fontSize: 13,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w600,
                            ),)
                        ],
                      ),
                    )
                    :Container(),
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
      ),
    );
  }
}

class AppTeamList{
  List<AppTeamCard> createTeamList(int year){
    List<AppTeamCard> appTeamList = List.empty(growable: true);
    appTeam[year].forEach((element){
      AppHead appHead=AppHead(element);
      appTeamList.add(AppTeamCard(appHead: appHead,));
    });
    return appTeamList;
  }
}
