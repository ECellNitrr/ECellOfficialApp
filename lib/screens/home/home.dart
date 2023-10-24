import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/screens/home/tabs/app_team/app_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'tabs/contact_us.dart';
import 'tabs/menu.dart';
import 'tabs/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    ProfileScreen(),
    MenuScreen(),
    ContactUsScreen(),
    AppTeamScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: _buildBottomNavBar(context),
      body: _children[_currentIndex],
    );
  }

  Widget _buildBottomNavBar(context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return SalomonBottomBar(
      backgroundColor: C.backgroundBottom,
      unselectedItemColor: C.menuButtonColor,
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        /// Profile
        SalomonBottomBarItem(
          icon: Icon(Icons.person,
            size: 30 * heightFactor,
          ),
          title: Text("Profile",style: TextStyle(fontSize: 22*heightFactor),),
          selectedColor: C.menuButtonColor,
        ),
        /// Home
        SalomonBottomBarItem(
          icon: Icon(Icons.home,size: 30 * heightFactor ,),
          title: Text("Home",
            style: TextStyle(fontSize: 22 * heightFactor),
          ),
          selectedColor: C.menuButtonColor,
        ),

        /// Contact
        SalomonBottomBarItem(
          icon: Icon(Icons.call,
              size: 30 * heightFactor,
            ),
          title: Text("Contact",
              style: TextStyle(fontSize: 22 * heightFactor),
            ),
          selectedColor: C.menuButtonColor
        ),

        ///App team
        SalomonBottomBarItem(
            icon: Icon(Icons.flutter_dash_outlined,
              size: 30 * heightFactor,
            ),
            title: Text("App Team",
              style: TextStyle(fontSize: 22 * heightFactor),
            ),
            selectedColor: C.menuButtonColor
        ),

      ],
    );
  }
}
