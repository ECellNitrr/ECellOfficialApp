import 'package:ecellapp/core/res/colors.dart';
import 'package:flutter/material.dart';
import 'tabs/contact_us.dart';
import 'tabs/menu.dart';
import 'tabs/profile.dart';

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
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(height / 20)),
      child: Container(
        height: height / 10,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                activeIcon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        C.selectedIconThemeGrad1,
                        C.selectedIconThemeGrad2,
                        C.selectedIconThemeGrad3,
                      ],
                    ),
                  ),
                  constraints: BoxConstraints.tightFor(width: 50, height: 50),
                  child: Icon(
                    Icons.person_outline,
                    color: C.primaryUnHighlightedColor,
                  ),
                ),
                icon: Icon(Icons.person_outline),
                label: 'Profile'),
            BottomNavigationBarItem(
              activeIcon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      C.selectedIconThemeGrad1,
                      C.selectedIconThemeGrad2,
                      C.selectedIconThemeGrad3,
                    ],
                  ),
                ),
                constraints: BoxConstraints.tightFor(width: 50, height: 50),
                child: Icon(
                  Icons.home_outlined,
                  color: C.primaryUnHighlightedColor,
                ),
              ),
              icon: new Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      C.selectedIconThemeGrad1,
                      C.selectedIconThemeGrad2,
                      C.selectedIconThemeGrad3,
                    ],
                  ),
                ),
                constraints: BoxConstraints.tightFor(width: 50, height: 50),
                child: Icon(
                  Icons.phone_outlined,
                  color: C.primaryUnHighlightedColor,
                ),
              ),
              icon: new Icon(Icons.phone_outlined),
              label: 'Contact Us',
            ),
          ],
        ),
      ),
    );
  }
}
