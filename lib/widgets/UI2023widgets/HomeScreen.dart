import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecellapp/screens/sponser_new/cubit/sponsors_cubit.dart';
import 'package:ecellapp/screens/sponser_new/sponsor_carousel.dart';
import 'package:ecellapp/screens/sponser_new/sponsors_repository.dart';
import 'package:ecellapp/widgets/raisedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/res/colors.dart';

class WelcomeText extends StatelessWidget {
  WelcomeText({Key? key, required this.text, required this.size})
      : super(key: key);

  String text;
  double size;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      text,
      style: GoogleFonts.raleway(
        fontSize: size,
        fontWeight: FontWeight.bold, // Adjust the font size as needed
        color: C.primaryHighlightedColor, // Set the text color
        shadows: <Shadow>[
          Shadow(
            offset: Offset(2.0, 2.0), // Horizontal and vertical shadow offset
            blurRadius: 8.0, // Shadow blur radius
            color: C.backgroundBottom, // Shadow color
          ),
        ],
      ),
    ));
  }
}

class HomeImageSection extends StatelessWidget {
  HomeImageSection(
      {required this.height,
        required this.image,
        required this.text,
        required this.elementColor,
        required this.gradientColor,
        required this.onPressed,
      });
  final double height;
  final String image;
  final Color gradientColor;
  final Color elementColor;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(20.0)), // Rounded corners
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [C.backgroundBottom, Colors.transparent],
              ),
            ),
          ),
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [gradientColor, Colors.transparent, Colors.transparent],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10, 0.0, 0.0),
              child: WelcomeText(
                text: text,
                size: 32.0,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, height * 0.1, 10.0, 0.0),
                child: IconButton(
                  color: elementColor,
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 35.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class HomeImageCarouselSection extends StatelessWidget {
  HomeImageCarouselSection(
      {required this.height,
        required this.text,
        required this.elementColor,
        required this.gradientColor,
        required this.onPressed,
      });
  final double height;
  final Color gradientColor;
  final Color elementColor;
  final String text;
  final VoidCallback onPressed;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(20.0)), // Rounded corners
            ),
            child: BlocProvider(
                create: (_) => SponsorsCubit(APISponsorsRepository()),
                child: SponserCarousel()),
          ),
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [C.backgroundBottom, Colors.transparent],
              ),
            ),
          ),
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [gradientColor, Colors.transparent, Colors.transparent],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 10, 0.0, 0.0),
              child: WelcomeText(
                text: text,
                size: 32.0,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, height * 0.1, 10.0, 0.0),
                child: IconButton(
                  color: elementColor,
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 35.0,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class HomeScreenButton extends StatelessWidget {
  HomeScreenButton({required this.height, required this.width, required this.onPressed, required this.color, required this.image, required this.text});
  final double height;
  final double width;
  final VoidCallback onPressed;
  final Color color;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: height * 0.14,
            width: width * 0.27,
            child: MenuButton(
              onPressed: onPressed,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    10.0), // Customize the button's shape
              ),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(height: height * 0.008),
          Text(
            text,
            style: GoogleFonts.raleway(
                fontWeight: FontWeight.bold,
                color: C.menuButtonColor),
          )
        ],
      ),
    );
  }
}
