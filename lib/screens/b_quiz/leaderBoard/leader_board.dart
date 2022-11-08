import 'package:ecellapp/models/leader_board.dart';
import 'package:ecellapp/screens/b_quiz/leaderBoard/cubit/leaderboard_cubit.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';

import 'package:ecellapp/widgets/stateful_wrapper.dart';

import 'leader_card.dart';

class LeaderScreen extends StatelessWidget {
  LeaderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllLeaders(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            padding: EdgeInsets.only(left: D.horizontalPadding - 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [C.backgroundTop1, C.backgroundBottom1],
            ),
          ),
          child: BlocBuilder<LeaderCubit, LeaderState>(
            builder: (context, state) {
              if (state is LeaderInitial)
                return _buildLoading(context);
              else if (state is LeaderSuccess)
                return _buildSuccess(context, state.leaderList);
              else if (state is LeaderLoading)
                return _buildLoading(context);
              else
                return ReloadOnErrorWidget(() => _getAllLeaders(context));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Data> LeaderList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;

    List<Widget> LeaderContentList = [];
    int t=0;
    LeaderList.forEach((element) {
      LeaderContentList.add(LeaderCard(
          Leader: element,
          rank: LeaderContentList.length + 1,
        ));
    });

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(top: top + 56),
            child: Column(
              children: <Widget>[
                Text(
                  "LeaderBoard",
                  style: TextStyle(
                    fontSize: ratio > 0.5 ? 45 : 50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: LeaderContentList),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _getAllLeaders(BuildContext context) {
    final cubit = context.read<LeaderCubit>();
    cubit.getLeaderList();
  }
}