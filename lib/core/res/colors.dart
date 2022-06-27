import 'package:flutter/material.dart';

class C {
  C._();

  /// background color gradient
  static final Color backgroundTop = HexColor("#4F3FA0");
  static final Color backgroundBottom = HexColor("#180C58");

  /// animated rings colors (1->4 increasingsize)
  static final Color ring1 = HexColor("#2DFFF9");
  static final Color ring2 = HexColor("#FB28E6");
  static final Color ring3 = HexColor("#F8F010");
  static final Color ring4 = HexColor("#AE82FF");

  /// home screen buttons
  static final Color eSummitButton1 = HexColor("#B67FFE");
  static final Color eSummitButton2 = HexColor("#FB28E6");
  static final Color eventsButton1 = HexColor("#BFF70E");
  static final Color eventsButton2 = HexColor("#3CCD72");
  static final Color sponsorsButton1 = HexColor("#2DEBFF");
  static final Color sponsorsButton2 = HexColor("#02A0F9");
  static final Color bQuizButton1 = HexColor("#EFEA79");
  static final Color bQuizButton2 = HexColor("#FB8329");
  static final Color aboutUsButton1 = HexColor("#AE82FF");
  static final Color aboutUsButton2 = HexColor("#4671FE");

  /// esummit + speakers background color gradient
  static final Color backgroundTop1 = HexColor("#B67EFE");
  static final Color backgroundBottom1 = HexColor("#FB28E6");

  /// theme colors
  static final Color primaryHighlightedColor = HexColor("#EF9BFF");
  static final Color primaryUnHighlightedColor = HexColor("#FFFFFF");
  static final Color secondaryColor = HexColor("#CECECE");

  /// button colors
  static final Color authButtonColor = HexColor("#A955F7");
  static final Color speakerButtonColor = HexColor('#8E31D5');

  /// selected icon theme
  static final Color selectedIconThemeGrad1 = HexColor("#FD8020");
  static final Color selectedIconThemeGrad2 = HexColor("#FF3838");
  static final Color selectedIconThemeGrad3 = HexColor("#FF1F88");
  static final Color eventsButtonGradientLeft = HexColor("##24cefe");
  static final Color eventsButtonGradientMid = HexColor("#5e83fd");
  static final Color eventsButtonGradientRight = HexColor("#9f38ff");

  /// FrameCardWidget colors
  static final Color downArrowColor = HexColor("#FD8020");
  static const Color blendSocialIconColorOne = Colors.black12;
  static const Color blendSocialIconColorTwo = Colors.black38;

  //Speaker Card fonts
  static final Color cardFontColor = HexColor("#A3A3A3");

  //Sponsor Background
  static final Color sponsorPageBackground = HexColor("#372981");

  //BQuiz Gradient Colors
  static final Color bQuizGradient1 = HexColor("#ffc158");
  static final Color bQuizGradient2 = HexColor("#dd19ad");
  static final Color bQuizGradient3 = HexColor("#5f00ff");
  static final Color bQuizGradient4 = HexColor("#145fff");
  static final Color bQuizGradient5 = HexColor("#00c3ff");
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
