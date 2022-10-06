import 'package:ecellapp/models/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';


class LeaderCard extends StatelessWidget {
  final Data Leader;
  final int rank;

  const LeaderCard({Key key, this.Leader, this.rank, Data leader}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: D.horizontalPaddingFrame),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: ExpansionTile(
                    title: Container(
                      height: ratio > 0.5 ? 140 : 160,
                      margin: EdgeInsets.only(left: 130),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Leader.username,
                            style: TextStyle(
                              fontSize: 25,
                              color: C.cardFontColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            Leader.email,
                            style: TextStyle(fontSize: 20, color: C.cardFontColor),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Score:${Leader.bquizScore}",
                            style: TextStyle(fontSize: 20, color: C.cardFontColor),
                          ),
                        ],
                      ),
                    ),
                    
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
