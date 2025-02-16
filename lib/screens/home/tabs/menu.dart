import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecellapp/widgets/UI2023widgets/expansiontile.dart';
import 'package:ecellapp/widgets/raisedButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/res/colors.dart';
import '../../../core/res/strings.dart';
import '../../../core/utils/injection.dart';
import '../../../models/global_state.dart';
import '../../../widgets/UI2023widgets/HomeScreen.dart';
import '../../../widgets/screen_background.dart';

import 'dart:math' as math;
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late ScrollController _scrollController;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    // Initialize the scroll controller
    _scrollController = ScrollController();

    // Add listener for scroll changes
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the controller to free up resources
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if _scrollController is initialized before using it
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleClick,
            icon: Icon(
              Icons.exit_to_app,
              color: Color.fromARGB(255, 227, 245, 247),
              size: 36,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'Logout',
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Stack(
            children: [
              ScreenBackground(elementId: 0),
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  S.assetEsummitImage,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: height * 0.4,
                left: width * 0.1,
                child: AnimatedOpacity(
                  opacity: 1.0 - (_scrollOffset / height).clamp(0.0, 1.0),
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    height: height * 0.4,
                    width: width * 0.8,
                    child: Image.asset(
                      S.assetEcellLogoWhite,
                      fit: BoxFit.fill,
                      opacity: const AlwaysStoppedAnimation<double>(0.2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 32.0, 0.0, 0.0),
                  child: Transform.translate(
                    offset: Offset(0, -_scrollOffset * 0.2),
                    child: WelcomeText(
                      text: "Entrepreneurship\nCell",
                      size: 45.0,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.08),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 5.0),
                  child: Transform.translate(
                    offset: Offset(0, _scrollOffset * 0.1),
                    child: WelcomeText(
                      text: "Explore ESUMMIT'23",
                      size: 35.0,
                    ),
                  ),
                ),
                Row(
                  children: [
                    _buildAnimatedButton(
                      "ESummit",
                      S.assetEsummitLogoImage,
                      () => Navigator.pushNamed(context, S.routeEsummit),
                    ),
                    _buildAnimatedButton(
                      "BQuiz",
                      S.assetQuizImage,
                      () => Navigator.pushNamed(context, S.routeBQuiz),
                    ),
                    _buildAnimatedButton(
                      "About Us",
                      S.assetEcellLogoBlack,
                      () {
                        S.teamApiYear = 2023;
                        Navigator.pushNamed(context, S.routeAboutUs);
                      },
                    ),
                  ],
                ),
                HomeImageSection(
                  height: height,
                  text: "Explore Events At\nESUMMIT'23",
                  image: S.assetEventImage,
                  elementColor: C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  onPressed: () => Navigator.pushNamed(context, S.routeEvents),
                ),
                HomeImageCarouselSection(
                    height: height,
                    text: "Meet Our \nSponsors",
                    elementColor: C.menuButtonColor,
                    gradientColor: C.backgroundBottom,
                    onPressed: () {
                      S.sponsorApiYear = 2023;
                      Navigator.pushNamed(context, S.routeSponsors);
                    }),
                HomeImageCarouselSection(
                    height: height,
                    text: "Merchendise",
                    elementColor: C.menuButtonColor,
                    gradientColor: C.backgroundBottom,
                    onPressed: () {
                      S.sponsorApiYear = 2023;
                      Navigator.pushNamed(context, S.routemerch);
                    }),
                HomeImageSection(
                  height: height,
                  text: "Speakers of\nESUMMIT'23",
                  elementColor: C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  image: S.assetHomeBackdrop,
                  onPressed: () => Navigator.pushNamed(context, S.routeSpeaker),
                ),
                HomeImageSection(
                  height: height,
                  text: "Gallery",
                  elementColor: C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  image: S.assetHomeBackdrop,
                  onPressed: () => Navigator.pushNamed(context, S.routeGallery),
                ),
                HomeImageSection(
                  height: height,
                  text: "Meet Our\nTeam",
                  elementColor: C.menuButtonColor,
                  gradientColor: C.backgroundBottom,
                  image: S.assetHomeBackdrop,
                  onPressed: () => Navigator.pushNamed(context, S.routeTeam),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(String text, String image, VoidCallback onTap) {
    // Scale factor based on scroll position
    double scale = 1.0 +
        (_scrollOffset / 200).clamp(0.0, 1.0) * 0.5; // Scale from 1.0 to 1.5

    return Transform.scale(
      scale: scale,
      child: AnimatedOpacity(
        opacity: 1.0 - (_scrollOffset / 200).clamp(0.0, 1.0),
        duration: Duration(milliseconds: 300),
        child: HomeScreenButton(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          onPressed: onTap,
          color: C.menuButtonColor,
          image: image,
          text: text,
        ),
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
        await sl.get<SharedPreferences>().remove('email');
        await sl.get<SharedPreferences>().remove('name');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Logged Out Successfully")));
        logout();
        Navigator.pushReplacementNamed(context, S.routeLogin);
    }
  }
}
