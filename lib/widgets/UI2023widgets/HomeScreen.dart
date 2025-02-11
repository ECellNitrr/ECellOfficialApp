import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecellapp/models/speaker.dart';
import 'package:ecellapp/screens/sponser_new/cubit/sponsors_cubit.dart';
import 'package:ecellapp/screens/sponser_new/sponsor_carousel.dart';
import 'package:ecellapp/screens/sponser_new/sponsors_repository.dart';
import 'package:ecellapp/widgets/raisedButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../core/res/colors.dart';
import '../../core/res/strings.dart';
import '../../models/event.dart';

class WelcomeText extends StatelessWidget {
  WelcomeText({
    Key? key,
    required this.text,
    required this.size,
  }) : super(key: key);

  String text;
  double size;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return Container(
        child: AutoSizeText(
      text,
      maxLines: 2,
      style: GoogleFonts.raleway(
        fontSize: size * heightFactor,
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
  EventText({
    Key? key,
    required this.color,
    required this.text,
    required this.size,
    required this.maxLines,
    this.overflow = TextOverflow.visible,
  }) : super(key: key);

  final String text;
  final Color color;
  final double size;
  final int maxLines;
  final TextOverflow overflow;
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
    double height = MediaQuery.of(context).size.height;
    double heightFactor = height / 1000;
    return Container(
        child: Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.raleway(
        fontSize: size * heightFactor,
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

class HomeImageSection extends StatefulWidget {
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
  _HomeImageSectionState createState() => _HomeImageSectionState();
}

class _HomeImageSectionState extends State<HomeImageSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _buttonBounceAnimation;

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Fade-in animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Sliding text animation (from left to right)
    _textSlideAnimation =
        Tween<Offset>(begin: Offset(-1.5, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Bounce effect for the button
    _buttonBounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.5 && !_isVisible) {
      // Start the animation when more than 50% of the widget is visible
      _isVisible = true;
      _controller.forward();
    } else if (info.visibleFraction == 0) {
      // Optionally reverse the animation when not visible (if needed)
      _isVisible = false;
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = widget.height / 1000;

    return VisibilityDetector(
      key: Key(widget.text), // Unique key for the visibility detector
      onVisibilityChanged: _onVisibilityChanged, // Detect visibility
      child: FadeTransition(
        opacity: _fadeAnimation, // Fade in animation
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: C.menuButtonColor.withOpacity(0.5),
                offset: Offset(5 * heightFactor, 5 * heightFactor),
                blurRadius: 8,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                // Image Container with gradient overlay
                Container(
                  height: widget.height * 0.17,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: widget.height * 0.17,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                // Sliding Text
                Align(
                  alignment: Alignment.topLeft,
                  child: SlideTransition(
                    position: _textSlideAnimation, // Slide in from left
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                      child: WelcomeText(
                        text: widget.text,
                        size: 28.0,
                      ),
                    ),
                  ),
                ),

                // Icon Button with bounce effect on tap
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: widget.onPressed,
                    child: ScaleTransition(
                      scale: _buttonBounceAnimation, // Bounce effect on button
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.0, widget.height * 0.1, 15.0, 10.0),
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 50.0 * heightFactor,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeImageCarouselSection extends StatefulWidget {
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
  _HomeImageCarouselSectionState createState() =>
      _HomeImageCarouselSectionState();
}

class _HomeImageCarouselSectionState extends State<HomeImageCarouselSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _buttonBounceAnimation;

  bool _isVisible = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Fade-in animation
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Sliding text animation (from left to right)
    _textSlideAnimation =
        Tween<Offset>(begin: Offset(-1.5, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Bounce effect for the button
    _buttonBounceAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction > 0.5 && !_isVisible) {
      // Start the animation when more than 50% of the widget is visible
      _isVisible = true;
      _controller.forward();
    } else if (info.visibleFraction == 0 && _isVisible) {
      // Optionally reset the animation when not visible
      _isVisible = false;
      _controller.reset();
    }
  }

  void _onButtonTap() {
    // Trigger the button bounce animation
    _controller.forward(from: 0);
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    double heightFactor = widget.height / 1000;

    return VisibilityDetector(
      key: Key(widget.text), // Unique key for the visibility detector
      onVisibilityChanged: _onVisibilityChanged, // Detect visibility
      child: FadeTransition(
        opacity: _fadeAnimation, // Fade in animation
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: C.menuButtonColor.withOpacity(0.5),
                offset: Offset(5 * heightFactor, 5 * heightFactor),
                blurRadius: 8,
                spreadRadius: -10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              children: [
                // Background Image with Border and Gradient
                Container(
                  height: widget.height * 0.17,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(S.assetHomeBackdrop),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: widget.height * 0.01),
                  height: widget.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: BlocProvider(
                    create: (_) => SponsorsCubit(APISponsorsRepository()),
                    child: SponserCarousel(),
                  ),
                ),
                Container(
                  height: widget.height * 0.17,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 5),
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [C.backgroundBottom, Colors.transparent],
                    ),
                  ),
                ),
                Container(
                  height: widget.height * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
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

                // Sliding Text
                Align(
                  alignment: Alignment.topLeft,
                  child: SlideTransition(
                    position: _textSlideAnimation, // Slide in from left
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
                      child: WelcomeText(
                        text: widget.text,
                        size: 32.0,
                        //color: Colors.white, // Ensure text is visible
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                // Icon Button with bounce effect on tap
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: _onButtonTap, // Handle tap with animation
                    child: ScaleTransition(
                      scale: _buttonBounceAnimation, // Bounce effect on button
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0.0, widget.height * 0.1, 14.0, 10.0),
                        child: Icon(
                          Icons.arrow_circle_right_outlined,
                          size: 50.0 * heightFactor,
                          color: Color.fromARGB(
                              255, 254, 254, 255), // Use elementColor
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
    double heightFactor = height / 1000;
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(-8, -4),
            blurRadius: 2,
            spreadRadius: -20)
      ]),
      child: Padding(
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
                  fontSize: 22 * heightFactor,
                  fontWeight: FontWeight.bold,
                  color: C.menuButtonColor),
            )
          ],
        ),
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Background Image
                Container(
                  height: widget.height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: AssetImage(widget.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient Overlay
                Container(
                  height: widget.height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [widget.gradientColor, Colors.transparent],
                    ),
                  ),
                ),
                // Event Image
                Positioned(
                  left: 10,
                  bottom: 10,
                  child: Container(
                    height: widget.height * 0.14,
                    width: widget.height * 0.14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/event-logos/${widget.event.id!}.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            // Event Details
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.event.name!,
                        style: TextStyle(
                          color: widget.elementColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Date: ${widget.event.date!}",
                        style: TextStyle(
                          color: widget.elementColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Venue: ${widget.event.venue!}",
                        style: TextStyle(
                          color: widget.elementColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    TextButton(
                      onPressed: _toggleExpansion,
                      child: Text("More Info", style: TextStyle(fontSize: 14)),
                    ),
                    if (widget.eventForm != "null")
                      TextButton(
                        onPressed: () async {
                          if (!await launchUrl(Uri.parse(widget.eventForm))) {
                            throw Exception('Could not launch URL');
                          }
                        },
                        child: Text("Register", style: TextStyle(fontSize: 15)),
                      ),
                  ],
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.event.details!,
                  style: TextStyle(fontSize: 10),
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
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
    double heightFactor = widget.height / 1000;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: C.menuButtonColor.withOpacity(0.3),
            offset: Offset(10 * heightFactor, 2 * heightFactor),
            blurRadius: 2,
            spreadRadius: -15,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: widget.height * 0.19,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        widget.gradientColor,
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Container(
                  height: widget.height * 0.19,
                  width: widget.height * 0.17,
                  child: Center(
                    child: Container(
                      height: widget.height * 0.15,
                      width: widget.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(
                          image: NetworkImage(
                              S.imgBaseUrl + widget.speaker.profilePic!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: widget.height * 0.19,
                  width: widget.height * 0.17,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: widget.height * 0.17, // Width for the image
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(6.0, 15.0, 0.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: EventText(
                                    color: C.backgroundBottom,
                                    text: widget.speaker.name!,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    size: 29.0,
                                  ),
                                ),
                                EventText(
                                  color: C.backgroundBottom,
                                  text: "${widget.speaker.company!}",
                                  maxLines: 2,
                                  size: 20.0,
                                  overflow: TextOverflow.visible,
                                ),
                                EventText(
                                  color: C.backgroundBottom,
                                  text: "Year: ${widget.speaker.year!}",
                                  maxLines: 1,
                                  size: 20.0,
                                ),
                              ],
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
                  ),
                ),
              ],
            ),
            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  padding:
                      const EdgeInsets.all(12.0), // Padding around the text
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        offset: Offset(0, 2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Align(
                    alignment:
                        Alignment.topLeft, // Align text to the top-left corner
                    child: WelcomeText(
                      text: widget.speaker.description!,
                      size:
                          14, // Slightly larger font size for better readability
                    ),
                  ),
                ),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
