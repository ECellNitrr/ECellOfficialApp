import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecellapp/widgets/raisedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/res/colors.dart';
import '../../../core/res/dimens.dart';
import '../../../core/res/strings.dart';
import '../../../core/utils/injection.dart';
import '../../../models/global_state.dart';
import '../../../widgets/UI2023widgets/HomeScreen.dart';
import '../../../widgets/ecell_animation.dart';
import '../../../widgets/screen_background.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Container(
          padding: EdgeInsets.only(left: D.horizontalPadding - 10, top: 10),
          child: PopupMenuButton<String>(
            onSelected: _handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ),
      ),
      body: Stack(children: [
        Stack(
          children: [
            ScreenBackground(
              elementId: 0,
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.transparent],
                ).createShader(
                    Rect.fromLTRB(0, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                S.assetEsummitImage,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 32.0, 0.0, 0.0),
              child: WelcomeText(
                text: "Entrepreneurship \nCell",
                size: 35.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(width*0.1, height*0.4, 0.0, 0.0),
              child: Container(
                height: height*0.4,
                width: width*0.8,
                child: Image.asset(S.assetEcellLogoWhite, fit: BoxFit.fill,opacity: const AlwaysStoppedAnimation<double>(0.5),),

              ),
            )
          ],
        ),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.21,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                child: WelcomeText(
                  text: "Explore ESUMMIT'23",
                  size: 22.0,
                ),
              ),
              Row(
                children: [
                  HomeScreenButton(
                      height: height,
                      width: width,
                      onPressed: (){
                        Navigator.pushNamed(context, S.routeEsummit);
                      },
                      color: C.menuButtonColor,
                      image: S.assetEsummitLogoImage,
                      text: 'ESummit'),
                  HomeScreenButton(
                      height: height,
                      width: width,
                      onPressed: (){
                        Navigator.pushNamed(context, S.routeBQuiz);
                      },
                      color: C.menuButtonColor,
                      image: S.assetQuizImage,
                      text: 'BQuiz'),
                  HomeScreenButton(
                      height: height,
                      width: width,
                      onPressed: (){
                        S.teamApiYear=2023;
                        Navigator.pushNamed(context, S.routeAboutUs);
                      },
                      color: C.menuButtonColor,
                      image: S.assetEcellLogoWhite,
                      text: 'About Us'),
                ],
              ),
              //Events
              HomeImageSection(
                height: height,
                image: S.assetEventImage,
                text: "Explore Events \nESUMMIT'23",
                elementColor: C.menuButtonColor,
                gradientColor: C.backgroundBottom,
                onPressed: (){Navigator.pushNamed(context, S.routeEvents);}
              ),
              //Sponsors
              HomeImageCarouselSection(
                  height: height,
                  text: "Meet Our \nSponsors",
                  elementColor:C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  onPressed: (){
                    S.sponsorApiYear=2019;
                    Navigator.pushNamed(context, S.routeSponsors);
                  }
              ),
              //Speakers
              HomeImageSection(
                  height: height,
                  image: S.assetEventImage,
                  text: "Speakers of\nESUMMIT'23",
                  elementColor: C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  onPressed: (){print( "fuck");}
              ),
              //Gallery
              HomeImageSection(
                  height: height,
                  image: S.assetEventImage,
                  text: "Gallery",
                  elementColor: C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  onPressed: (){print( "fuck");}
              ),
              SizedBox(height: height*0.1,)
            ],
          ),
        ),
      ],
      ),
    );
  }
  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }
  Future<void> _handleClick(String value) async {
    switch (value) {
      case 'Logout':
        Provider.of<GlobalState>(context, listen: false).user = null;
        await sl.get<SharedPreferences>().remove(S.tokenKeySharedPreferences);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Logged Out Successfuly")));
        logout();
        Navigator.pushReplacementNamed(context, S.routeLogin);
    }
  }
}
