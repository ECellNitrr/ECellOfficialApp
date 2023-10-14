import 'package:flutter/material.dart';

import '../res/colors.dart';

class AppTheme {
  static ThemeData themeData(BuildContext context) => Theme.of(context).copyWith(
        primaryColor: C.primaryHighlightedColor,
        hintColor: C.primaryUnHighlightedColor,
        inputDecorationTheme: InputDecorationTheme(
          border: UnderlineInputBorder(),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: C.primaryUnHighlightedColor)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: C.primaryHighlightedColor)),
          isDense: true,
          labelStyle: TextStyle(color: C.secondaryColor, fontSize: 15),
          contentPadding: EdgeInsets.all(0),
        ),
      );
}
