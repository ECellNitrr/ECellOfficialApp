import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecellapp/models/speaker.dart';
import 'package:ecellapp/screens/sponser_new/cubit/sponsors_cubit.dart';
import 'package:ecellapp/screens/sponser_new/sponsor_carousel.dart';
import 'package:ecellapp/screens/sponser_new/sponsors_repository.dart';
import 'package:ecellapp/widgets/raisedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/res/colors.dart';
import '../../core/res/strings.dart';
import '../../models/event.dart';

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


class EventText extends StatelessWidget {
  EventText(
      {Key? key,
        required this.color,
      required this.text,
      required this.size,
      required this.maxLines})
      : super(key: key);

  String text;
  final Color color;
  double size;
  int maxLines;
  // AutoSizeText(
  // event, {required TextStyle style}!.name!,
  // maxLines: 2,
  // style: TextStyle(
  // fontSize: 18,
  // color: C.cardFontColor,
  // fontWeight: FontWeight.w700,
  // ),
  // ),

  @override
  Widget build(BuildContext context) {
    return Container(
        child: AutoSizeText(
      text,
      maxLines: maxLines,
      style: GoogleFonts.raleway(
        fontSize: size,
        fontWeight: FontWeight.bold, // Adjust the font size as needed
        color: color, // Set the text color
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
  HomeImageSection({
    required this.height,
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
                size: 28.0,
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
  HomeImageCarouselSection({
    required this.height,
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
              borderRadius:
              BorderRadius.all(Radius.circular(20.0)), // Rounded corners
              image: DecorationImage(
                image: AssetImage(S.assetSpeakerBackdrop),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height * 0.17,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(20.0)), // Rounded corners
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
  HomeScreenButton(
      {required this.height,
      required this.width,
      required this.onPressed,
      required this.color,
      required this.image,
      required this.text});
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
                borderRadius:
                    BorderRadius.circular(10.0), // Customize the button's shape
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
                fontWeight: FontWeight.bold, color: C.menuButtonColor),
          )
        ],
      ),
    );
  }
}

class EventImageSection extends StatefulWidget {
  EventImageSection({
    required this.height,
    required this.image,
    required this.event,
    required this.eventForm,
    required this.elementColor,
    required this.gradientColor,
  });
  final double height;
  final String eventForm;
  final String image;
  final Event event;
  final Color gradientColor;
  final Color elementColor;

  @override
  State<EventImageSection> createState() => _EventImageSectionState();
}

class _EventImageSectionState extends State<EventImageSection> {
  bool isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: widget.height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)), // Rounded corners
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
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
                height: widget.height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      widget.gradientColor,
                      Colors.transparent,
                      Colors.transparent
                    ],
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
                    child: Row(
                      children: [
                        Container(
                          child: Image.network(widget.event.iconUrl!),
                          height: widget.height * 0.14,
                        ),
                        Container(
                          width: widget.height * 0.29,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  6.0, 15.0, 0.0, 0.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EventText(
                                    color: C.primaryHighlightedColor,
                                    text: widget.event.name!,
                                    maxLines: 2,
                                    size: 24.0,
                                  ),
                                  EventText(
                                    color: C.primaryHighlightedColor,
                                    text: "Date: ${widget.event.date!}",
                                    maxLines: 2,
                                    size: 14.0,
                                  ),
                                  EventText(
                                    color: C.primaryHighlightedColor,
                                    text: "Venue: DDU Auditorium",
                                    maxLines: 2,
                                    size: 14.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0.0, widget.height * 0.115, 10.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _toggleExpansion,
                          child: WelcomeText(text: "More Info", size: 14),
                        ),
                        (widget.eventForm == "null")
                            ? Container()
                            : TextButton(
                                onPressed: () async {
                                  if (!await launchUrl(
                                      Uri.parse(widget.eventForm))) {
                                    throw Exception('Could not launch URl');
                                  }
                                },
                                child: WelcomeText(text: "Register", size: 15),
                              )
                      ],
                    ),
                  ))
            ],
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WelcomeText(text: widget.event.details!, size: 10),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}

class SpeakerImageSection extends StatefulWidget {
  SpeakerImageSection({
    required this.height,
    required this.image,
    required this.speaker,
    required this.elementColor,
    required this.gradientColor,
  });
  final double height;
  final String image;
  final Speaker speaker;
  final Color gradientColor;
  final Color elementColor;

  @override
  _SpeakerImageSectionState createState() => _SpeakerImageSectionState();
}

class _SpeakerImageSectionState extends State<SpeakerImageSection> {
  bool isExpanded = false;

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: widget.height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)), // Rounded corners
                  image: DecorationImage(
                    image: AssetImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      widget.gradientColor,
                      Colors.transparent
                    ],
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      widget.gradientColor,
                      Colors.transparent,
                      Colors.transparent
                    ],
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
                width: widget.height * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)), // Rounded corners
                  image: DecorationImage(
                    image: NetworkImage(widget.speaker.profilePic!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
                width: widget.height * 0.17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(20.0)), // Rounded corners
                  image: DecorationImage(
                    image: AssetImage(S.assetProfileFrame),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: widget.height * 0.19,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      SizedBox(
                        height: widget.height * 0.14,
                        width: widget.height * 0.17,
                      ),
                      Container(
                        width: widget.height * 0.27,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                6.0, 15.0, 0.0, 0.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EventText(
                                  color: C.primaryHighlightedColor,
                                  text: widget.speaker.name!,
                                  maxLines: 2,
                                  size: 22.0,
                                ),
                                EventText(
                                  color: C.primaryHighlightedColor,
                                  text: "${widget.speaker.company!}",
                                  maxLines: 2,
                                  size: 16.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        0.0, widget.height * 0.115, 10.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: _toggleExpansion,
                          child: WelcomeText(text: "More Info", size: 14),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WelcomeText(text: widget.speaker.description!, size: 10),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
