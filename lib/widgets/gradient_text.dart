import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  GradientText(
    this.text, {
    required this.gradient,
  });

  final String text;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height/1000;
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
            // The color must be set to white for this to work
            color: Colors.white,
            fontSize: 60*heightFactor,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
