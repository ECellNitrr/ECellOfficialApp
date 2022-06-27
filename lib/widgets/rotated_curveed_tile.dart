import 'package:ecellapp/core/res/colors.dart';
import 'package:flutter/material.dart';

class RotatedCurvedTile extends StatelessWidget {
  final String name;
  final bool checked;
  final Function onTap;

  RotatedCurvedTile({this.name, this.checked, this.onTap});

  @override
  Widget build(BuildContext context) {
    Widget child = Container(
      color: checked ? HexColor("#372981") : Colors.white,
      margin: EdgeInsets.zero,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Text(
        name,
        style: TextStyle(color: checked ? Colors.white : Colors.purple, fontSize: 20),
      ),
    );
    if (checked) {
      child = CustomPaint(
        painter: CustomClipPainter._(
          clipper: InnerRoundClip(),
          shadow: Shadow(blurRadius: 2, color: Colors.grey),
        ),
        child: ClipPath(clipper: InnerRoundClip(), child: child),
      );
    }
    return Container(
      margin: const EdgeInsets.only(left: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: RotatedBox(quarterTurns: 3, child: child),
      ),
    );
  }
}

class InnerRoundClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double upperC = 20, lowerC = 10;
    var path = Path();

    path.moveTo(upperC + lowerC, 0);
    path.quadraticBezierTo(lowerC, 0, lowerC, upperC);

    path.lineTo(lowerC, size.height - lowerC);
    path.quadraticBezierTo(lowerC, size.height, 0, size.height);

    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width - lowerC,
      size.height,
      size.width - lowerC,
      size.height - lowerC,
    );

    path.lineTo(size.width - lowerC, upperC);
    path.quadraticBezierTo(size.width - lowerC, 0, size.width - (upperC + lowerC), 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class CustomClipPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  CustomClipPainter._({@required this.shadow, @required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipRect = clipper.getClip(size).shift(Offset(-2, 0));
    canvas.drawPath(clipRect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
