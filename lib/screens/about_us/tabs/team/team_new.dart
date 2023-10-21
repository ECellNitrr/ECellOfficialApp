import 'dart:ffi';

import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:ecellapp/screens/about_us/tabs/team/Widget/team_card_2.dart';
import 'package:ecellapp/screens/about_us/tabs/team/Widget/team_card_new.dart';
import 'package:ecellapp/screens/about_us/tabs/team/app_team/app_team.dart';
import 'package:ecellapp/screens/about_us/tabs/team/cubit/team_cubit_new.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team_list.dart';
import 'package:ecellapp/screens/about_us/tabs/team/widget/team_card.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_list_tab_scroller/scrollable_list_tab_scroller.dart';

import '../../../../widgets/raisedButton.dart';
import '../../../../widgets/rotated_curveed_tile.dart';
// import 'cubit/team_cubit.dart';

class TeamScreenNew extends StatelessWidget {
  const TeamScreenNew({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<int> yearList = [2023, 2022];
    return StatefulWrapper(
      onInit: () => _getAllTeamMembers(context),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Container(
              padding: EdgeInsets.only(left: D.horizontalPadding - 10, top: 10),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            title: Center(
              child: Text(
                "Our Team",
                style: GoogleFonts.raleway(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5),
              ),
            ),
            actions: [
              Container(
                width: width * 0.25,
                height: 50,
                child: DropdownMenu<int>(
                  inputDecorationTheme: InputDecorationTheme(
                    isCollapsed: true,
                    enabledBorder: InputBorder.none,
                  ),
                  textStyle: TextStyle(color: Colors.white),
                  leadingIcon: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                  ),
                  onSelected: ((value) {
                    S.teamApiYear = value!;
                    _getAllTeamMembers(context);
                  }),
                  initialSelection: yearList.first,
                  dropdownMenuEntries:
                      yearList.map<DropdownMenuEntry<int>>((int value) {
                    return DropdownMenuEntry<int>(
                        value: value, label: value.toString());
                  }).toList(),
                ),
              )
            ],
          ),
          body: Stack(
            children: [
              Stack(children: [
                ScreenBackground(elementId: 0),
              ]),
              BlocBuilder<TeamCubitNew, TeamStateNew>(
                builder: (context, state) {
                  if (state is TeamInitial)
                    return _buildLoading(context);
                  else if (state is TeamSuccess)
                    return _buildSuccess(context, state.teamList);
                  else if (state is TeamLoading)
                    return _buildLoading(context);
                  else
                    return ReloadOnErrorWidget(
                        () => _getAllTeamMembers(context));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<TeamCategory> data) {
    double top = MediaQuery.of(context).viewPadding.top;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<String> list = [
      "Director",
      "Head of CDC",
      "Faculty Incharge",
      "Overall Co-ordinators",
      "Head Co-ordinators",
    ];

    return DefaultTextStyle.merge(
        style:
            GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true;
          },
          child: Stack(
            children: [
              Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.1, height * 0.4, 0.0, 0.0),
                  child: Container(
                    height: height * 0.4,
                    width: width * 0.8,
                    child: Image.asset(
                      S.assetEcellLogoWhite,
                      fit: BoxFit.contain,
                      opacity: const AlwaysStoppedAnimation<double>(0.5),
                    ),
                  ),
                ),
              Column(
                children: [
                  SizedBox(
                    height: top + 45,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) => Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (data[index].members.length > 0)
                            Text(data[index].category,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.raleway(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          SizedBox(
                            height: 10,
                          ),
                          // ...data[index].members.map((e) => TeamsCardNew(teamMember: e)),
                          GridView.count(
                            childAspectRatio:
                                list.contains(data[index].category)
                                    ? (0.8 / 1)
                                    : (1 / 0.5),
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            padding: data[index].members.length == 1
                                ? EdgeInsets.symmetric(
                                    horizontal: width * 0.25, vertical: 5)
                                : EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            crossAxisCount:
                                data[index].members.length == 1 ? 1 : 2,
                            children: [
                              ...list.contains(data[index].category)
                                  ? data[index]
                                      .members
                                      .map((e) => TeamsCardNew(teamMember: e))
                                  : List.generate(
                                      data[index].members.length,
                                      (i) => TeamsCard2(
                                          teamMember: data[index].members[i]))
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  )
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _getAllTeamMembers(BuildContext context) {
    final cubit = context.read<TeamCubitNew>();
    cubit.getAllTeamMembers();
  }
}
