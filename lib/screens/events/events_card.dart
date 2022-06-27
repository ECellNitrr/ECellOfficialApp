import 'package:flutter/material.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    var eventDateTime = event.date.split("T");
    String date = eventDateTime[0], time = eventDateTime[1].split("+")[0].substring(0, 5);
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: D.horizontalPaddingFrame),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 22.5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  ExpansionTile(
                    title: Container(
                      //To decrease bottom of card
                      height: ratio > 0.5 ? 150 : 170,
                      margin: EdgeInsets.only(left: ratio > 0.5 ? 120 : 140),
                      padding: EdgeInsets.only(bottom: 50, top: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            event.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Date:" + "\t" * 4 + "$date",
                            style: TextStyle(
                              fontSize: 18,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Time:" + "\t" * 3 + "$time",
                            style: TextStyle(
                              fontSize: 18,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Venue:" + "\t" + "${event.venue}",
                            style: TextStyle(
                              fontSize: 18,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Text(
                          event.details,
                          style: TextStyle(color: C.cardFontColor),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    right: 25,
                    top: ratio > 0.5 ? 115 : 135,
                    child: Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: <Color>[
                            C.eventsButtonGradientLeft,
                            C.eventsButtonGradientRight,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.16),
                            offset: Offset(0.0, 5),
                            blurRadius: 10,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            //TODO: Add Register to event Intent
                          },
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: C.primaryUnHighlightedColor,
                                fontSize: ratio > 0.5 ? 12 : 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.25,
                              ),
                            ),
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
        Positioned(
          left: -10,
          height: ratio > 0.5 ? 220 : 240,
          width: ratio > 0.5 ? 170 : 190,
          child: Stack(
            children: [
              Image.asset(
                S.assetEventFrame,
                fit: BoxFit.cover,
                height: 240,
              ),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(0.0, 5),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage(event.iconUrl),
                    radius: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
