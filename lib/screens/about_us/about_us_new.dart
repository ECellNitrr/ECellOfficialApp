import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/screens/about_us/tabs/aim/aim.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team_new.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutUsScreenNew extends StatefulWidget {
  @override
  _AboutUsScreenNewState createState() => _AboutUsScreenNewState();
}

class _AboutUsScreenNewState extends State<AboutUsScreenNew> {
  int _currentIndex = 0;
  final tabs = [AimScreen(), TeamScreenNew()];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        tabs[_currentIndex],
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildBottomNavBar(context),
        ),
      ],
    );
  }

  Widget _buildBottomNavBar(context) {
    double width = MediaQuery.of(context).size.width;
    final _controller = NotchBottomBarController(index: _currentIndex);
    return AnimatedNotchBottomBar(
      bottomBarWidth: 200,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Image.asset(
            S.assetAIMIcon,
            height: 20,
            color: Colors.blueGrey,
          ),
          activeItem: Image.asset(
            S.assetAIMIcon,
            height: 20,
            color: Colors.blueAccent,
          ),
        ),
        BottomBarItem(
          inActiveItem: Image.asset(
            S.assetTeamIcon,
            height: 20,
            color: Colors.blueGrey,
          ),
          activeItem: Image.asset(
            S.assetTeamIcon,
            height: 20,
            color: Colors.blueAccent,
          ),
        ),
      ],
      notchBottomBarController: _controller,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      }, // Provide the appropriate controller
    );
  }
}
