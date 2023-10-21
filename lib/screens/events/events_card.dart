import 'package:auto_size_text/auto_size_text.dart';
import 'package:ecellapp/widgets/UI2023widgets/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/models/event.dart';

class EventCard extends StatelessWidget {
  final Event? event;
  final String eventForm;

  const EventCard({Key? key, this.event, required this.eventForm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double height = MediaQuery.of(context).size.height;
    return EventImageSection(
      height: height,
      eventForm: eventForm,
      image: S.assetEventImage,
      event: event!,
      elementColor: C.menuButtonColor,
      gradientColor: C.backgroundBottom,
    );
  }
}
