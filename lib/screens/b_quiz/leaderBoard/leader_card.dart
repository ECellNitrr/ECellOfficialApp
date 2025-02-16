import 'package:ecellapp/models/leader_board.dart';
import 'package:flutter/material.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/leaderboard_repository.dart';
import 'package:ecellapp/core/res/strings.dart';

class LeaderCard extends StatelessWidget {
  final Data? Leader;
  final int? rank;

  const LeaderCard({
    Key? key,
    this.Leader,
    this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String phoneORemail = " ";
    if (APILeaderRepository.UNEmail[Leader!.username] != null) {
      phoneORemail = APILeaderRepository.UNEmail[Leader!.username];
    }
    if (APILeaderRepository.UNEmail[Leader!.username] == null) {
      String? ph = " ";
      if (Leader!.phone != null) {
        ph = (Leader!.phone)?.substring(0, 5);
      }
      phoneORemail = ph! + "XXXXX";
    }
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                offset: Offset(0, 20),
                blurRadius: 3,
                spreadRadius: -10)
          ]),
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: height * 0.01),
      height: height * 0.1,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '#',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                "$rank",
                style: TextStyle(fontSize: 28, color: Colors.black),
              ),
              rank == 1
                  ? Image.asset(
                      S.assetFirstMedalIcon,
                      height: height * 0.05,
                    )
                  : SizedBox(
                      width: width * 0.01,
                    ),
              rank == 2
                  ? Image.asset(
                      S.assetSecondMedalIcon,
                      height: height * 0.05,
                    )
                  : SizedBox(
                      width: width * 0.01,
                    ),
              rank == 3
                  ? Image.asset(
                      S.assetThirdMedalIcon,
                      height: height * 0.05,
                    )
                  : SizedBox(
                      width: width * 0.01,
                    ),
            ],
          ),
          Text(Leader!.username,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black)),
          Row(
            children: [
              Image.asset(
                S.assetScoreIcon,
                height: height * 0.02,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              Text("${Leader!.bquizScore}",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
