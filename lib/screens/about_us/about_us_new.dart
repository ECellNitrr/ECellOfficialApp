import 'package:ecellapp/screens/about_us/tabs/aim/aim.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../../core/res/colors.dart';
import '../../core/res/strings.dart';

class AboutUsScreenNew extends StatefulWidget {
  int index;
  AboutUsScreenNew({required this.index});
  @override
  _AboutUsScreenNewState createState() => _AboutUsScreenNewState(index);
}

class _AboutUsScreenNewState extends State<AboutUsScreenNew> {
  int _currentIndex = 0;
  final tabs = [AimScreen(), TeamScreenNew()];
  _AboutUsScreenNewState(int index){
    this._currentIndex = index;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:  _buildBottomNavBar(context),
      body: tabs[_currentIndex],

    );
  }

  Widget _buildBottomNavBar(context) {
    double height = MediaQuery.of(context).size.height;
    return SalomonBottomBar(
      backgroundColor: C.backgroundBottom,
      unselectedItemColor: C.menuButtonColor,
      currentIndex: _currentIndex,
      onTap: (i) => setState(() => _currentIndex = i),
      items: [
        /// Profile
        SalomonBottomBarItem(
          icon: Image.asset(S.assetAIMIcon),
          title: Text("Aim"),
          selectedColor: C.menuButtonColor,
        ),
        /// Home
        SalomonBottomBarItem(
          icon: Image.asset(S.assetTeamIcon),
          title: Text("Team"),
          selectedColor: C.menuButtonColor,
        ),
      ],
    );
  }
}
