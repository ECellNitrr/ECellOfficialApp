import 'package:flutter/material.dart';

import '../core/res/colors.dart';
import '../core/res/strings.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({this.elementId = 0});

  /// Id of the elemet that is required in the background along with the gradient.
  ///
  /// Refer the key table below.
  /// - `0`: No element (default)
  /// - `1`: Basic bubbles
  /// - `2`: Colorful bubbles
  final int elementId;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [C.backgroundTop, C.backgroundBottom],
        ),
      ),
      child: child(context),
    );
  }

  Widget child(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (elementId == 1) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(S.assetTopRightBasic, width: width * 0.9),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(S.assetBottomLeftBasic, width: width * 0.4),
          ),
        ],
      );
    } else if (elementId == 2) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(S.assetTopLeftColorful, width: width / 2),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(S.assetTopRightColorful, width: width / 2),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(S.assetBottomLeftColorful, width: width / 2),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(S.assetBottomRightColorful, width: width / 2),
          ),
        ],
      );
    }
    return null;
  }
}
