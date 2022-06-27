import 'dart:ui';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ECellLogoAnimation extends StatefulWidget {
  final double size;
  ECellLogoAnimation({Key key, @required this.size}) : super(key: key);
  @override
  _ECellLogoAnimationState createState() => _ECellLogoAnimationState();
}

class _ECellLogoAnimationState extends State<ECellLogoAnimation> with TickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 4));

    animation = Tween(begin: -math.pi, end: math.pi).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double size = widget.size;
    return Stack(
      children: [
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: size, bottom: size),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return CustomPaint(
                  painter: SolidRingsPainter(size, animation.value),
                );
              },
            )),
        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: size, bottom: size),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return CustomPaint(
                  painter: BlurredRingsPainter(size, animation.value),
                );
              },
            )),
        Center(
          child: Image.asset(S.assetEcellLogoWhite, width: size - 80),
        )
      ],
    );
  }
}

class SolidRingsPainter extends CustomPainter {
  final double radians;
  final double ringSize;
  SolidRingsPainter(this.ringSize, this.radians);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = C.ring4
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(Offset(size.width / 2, size.height / 2) & Size(ringSize, ringSize), 0,
        2 * math.pi, false, paint);
    var paint1 = Paint()
      ..color = C.ring3
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        Offset(size.width / 2 + 10, size.height / 2 + 10) & Size(ringSize - 20, ringSize - 20),
        0 + radians,
        math.pi,
        false,
        paint1);
    var paint2 = Paint()
      ..color = C.ring2
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        Offset(size.width / 2 + 20, size.height / 2 + 20) & Size(ringSize - 40, ringSize - 40),
        0,
        2 * math.pi,
        false,
        paint2);
    var paint3 = Paint()
      ..color = C.ring1
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
        Offset(size.width / 2 + 30, size.height / 2 + 30) & Size(ringSize - 60, ringSize - 60),
        0 - radians,
        math.pi,
        false,
        paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BlurredRingsPainter extends CustomPainter {
  final double ringSize;
  final double radians;
  BlurredRingsPainter(this.ringSize, this.radians);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = C.ring4
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..imageFilter = ImageFilter.blur(sigmaX: 4, sigmaY: 4);
    canvas.drawArc(Offset(size.width / 2, size.height / 2) & Size(ringSize, ringSize), 0,
        2 * math.pi, false, paint);
    var paint1 = Paint()
      ..color = C.ring3
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..imageFilter = ImageFilter.blur(sigmaX: 4, sigmaY: 4);
    canvas.drawArc(
        Offset(size.width / 2 + 10, size.height / 2 + 10) & Size(ringSize - 20, ringSize - 20),
        0 + radians,
        math.pi,
        false,
        paint1);
    var paint2 = Paint()
      ..color = C.ring2
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..imageFilter = ImageFilter.blur(sigmaX: 4, sigmaY: 4);
    canvas.drawArc(
        Offset(size.width / 2 + 20, size.height / 2 + 20) & Size(ringSize - 40, ringSize - 40),
        0,
        2 * math.pi,
        false,
        paint2);
    var paint3 = Paint()
      ..color = C.ring1
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..imageFilter = ImageFilter.blur(sigmaX: 4, sigmaY: 4);
    canvas.drawArc(
        Offset(size.width / 2 + 30, size.height / 2 + 30) & Size(ringSize - 60, ringSize - 60),
        0 - radians,
        math.pi,
        false,
        paint3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
