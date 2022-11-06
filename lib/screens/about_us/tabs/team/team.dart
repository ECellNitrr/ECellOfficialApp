import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:ecellapp/screens/about_us/tabs/team/app_team/app_team.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team_list.dart';
import 'package:ecellapp/screens/about_us/tabs/team/widget/team_card.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../widgets/raisedButton.dart';
import '../../../../widgets/rotated_curveed_tile.dart';
import 'cubit/team_cubit.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllTeamMembers(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            padding: EdgeInsets.only(left: D.horizontalPadding - 10, top: 10),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: C.teamsbackground, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        body: Stack(
          children: [
            ScreenBackground(elementId: 0),
            BlocBuilder<TeamCubit, TeamState>(
              builder: (context, state) {
                if (state is TeamInitial)
                  return _buildLoading(context);
                else if (state is TeamSuccess)
                  return _buildSuccess(context, state.teamList);
                else if (state is TeamLoading)
                  return _buildLoading(context);
                else
                  return ReloadOnErrorWidget(() => _getAllTeamMembers(context));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<TeamCategory> data) {
    double top = MediaQuery.of(context).viewPadding.top;
    ScrollController _scrollController = ScrollController();

    // ignore: close_sinks
    BehaviorSubject<int> subject = BehaviorSubject.seeded(0);

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: Container(
          color: Colors.white,
          child: StreamBuilder<int>(
            initialData: 0,
            stream: subject.stream,
            builder: (context, snapshot) {
              int i = snapshot.data!.toInt();
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80, top: 120),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: data
                              .map((spon) {
                            String tab = spon.category;
                            return RotatedCurvedTile(
                              checked: tab == data[i].category,
                              name: tab,
                              onTap: () =>
                                  subject.add(data.indexWhere((e) => e.category == tab)),
                            );
                          })
                              .toList()
                              .sublist(0, 7),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 15,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      ),
                      child: Container(
                        color: C.sponsorPageBackground,
                        width: double.infinity,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: top + 56),
                              Text(
                                "Our Team",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: LegacyRaisedButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30),),),
                                      color: C.speakerButtonColor,
                                      onPressed: (){
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context)=>TeamList())));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 130,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Yearwise Teams",
                                          style: TextStyle(
                                            color: C.primaryUnHighlightedColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(0, 0.5),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: LegacyRaisedButton(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30),),),
                                      color: C.speakerButtonColor,
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: ((context)=>AppTeamScreen())));
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 165,
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Contact App Team",
                                          style: TextStyle(
                                            color: C.primaryUnHighlightedColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                            shadows: [
                                              Shadow(
                                                color: Colors.black,
                                                offset: Offset(0, 0.5),
                                                blurRadius: 3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],),
                              ),
                              ...data[i].members.map((e) => TeamsCard(teamMember: e)),
                              //! Fix to avoid non-scrollable state
                              Container(height: 200)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _getAllTeamMembers(BuildContext context) {
    final cubit = context.read<TeamCubit>();
    cubit.getAllTeamMembers();
  }
}