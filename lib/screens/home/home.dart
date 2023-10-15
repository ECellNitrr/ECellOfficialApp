import 'package:ecellapp/core/res/colors.dart';
import 'package:flutter/material.dart';
import 'tabs/contact_us.dart';
import 'tabs/menu.dart';
import 'tabs/profile.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  final List<Widget> _children = [ProfileScreen(), MenuScreen(), ContactUsScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _children[_currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomNavBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(context) {
    double height = MediaQuery.of(context).size.height;
    final _controller = NotchBottomBarController(index: _currentIndex);
    return AnimatedNotchBottomBar(
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Icon(
            Icons.person,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.person,
            color: Colors.blueAccent,
          ),
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.home_filled,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.home_filled,
            color: Colors.blueAccent,
          ),
        ),
        BottomBarItem(
          inActiveItem: Icon(
            Icons.call,
            color: Colors.blueGrey,
          ),
          activeItem: Icon(
            Icons.call,
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
