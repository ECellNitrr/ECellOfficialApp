import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/models/team.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:ecellapp/screens/about_us/tabs/team/Widget/teams_card.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/rotated_curveed_tile.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cubit/team_cubit.dart';

class TeamScreen1 extends StatefulWidget {
  @override
  State<TeamScreen1> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen1> {
  // const TeamScreen({required Key key}) : super(key: key);
  final year = [
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011"
  ];
  final yearl = [
    "2020",
    "2019",
    "2018",
    "2017",
    "2016",
    "2015",
    "2014",
    "2013",
    "2012",
    "2011",
    "2010"
  ];
  String tab = "2023";

  int i(int? name) {
    if (name == null) throw Exception();
    return name;
  }

  void _launchURL(Uri url) async => await launchUrl(url);
  // const Url = url;
  // if (await canLaunchUrl(url)) {
  //   await launchUrl(url);
  // } else {
  //   throw 'Could not launch $url';
  // }

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
              icon: Icon(Icons.arrow_back_ios,
                  color: C.teamsBackground, size: 30),
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
              // int i = snapshot.data;
              return Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100, top: 110),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                children: <Widget>[
                                  Container(
                                    child: ElevatedButton(
                                      child: RotatedBox(
                                          quarterTurns: 3, child: Text("2022")),
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(

                                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),
                                      ),
                                    ),
                                  ),
                                ]),
                            for (int i = 0; i < 11; i++)
                              ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  padding: const EdgeInsets.all(8),
                                  children: <Widget>[
                                    Container(
                                      child: ElevatedButton(
                                        child: RotatedBox(
                                            quarterTurns: 3,
                                            child: Text(year[i])),
                                        onPressed: () {
                                          _launchURL(Uri.parse(
                                              'https://ecell.nitrr.ac.in/team/${yearl[i]}'));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0, vertical: 20.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0)
                                          ),

                                        ),
                                      ),
                                    ),
                                  ]),
                          ],
                          // child: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.stretch,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   mainAxisSize: MainAxisSize.max,
                          //   children:
                          //     year.map((x){
                          //         return(RotatedCurvedTile(
                          //           checked: x == year[i(snapshot.data)],
                          //           name: x,
                          //           onTap: () {
                          //             subject.add(year.indexWhere((e) => year[i(snapshot.data)] == x));
                          //             setState(() {
                          //               S.getTeamUrl = S.baseUrl + "team/list/$x/";
                          //             });},
                          //
                          //             ));}).toList(),
                          //
                          //   // children: year
                          //   //     .map((spon) {
                          //   //   String tab = spon;
                          //   //   return RotatedCurvedTile(
                          //   //     checked: tab == year[i(snapshot.data)],
                          //   //     name: tab,
                          //   //     onTap: () {
                          //   //         subject.add(year.indexWhere((e) => year[i(snapshot.data)] == tab));
                          //   //         S.getTeamUrl = S.baseUrl + "team/list/$tab/";}
                          //   //   );
                          //   // })
                          //   //     .toList()
                          //   //     .sublist(0,3),
                          // ),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(height: top + 56),
                                Text(
                                  "Our Team 2022",
                                  style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int i = 0; i < 7; i++)
                                      ListView(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        padding: const EdgeInsets.all(8),
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            // width: 20,
                                            color: Colors.amber[600],
                                            child: Center(
                                                child: Text(data[i].category,
                                                    style: TextStyle(
                                                        fontSize: 20))),
                                          ),
                                          ...data[i]
                                              .members
                                              .map((e) => TeamsCard(
                                                    teamMember: e,
                                                    key: null,
                                                  )),
                                        ],
                                      ),
                                  ],
                                ),
                                // ...data[i].members.map((e) => TeamsCard(teamMember: e))

                                SizedBox(height: 20),
                                // ...data[i].members.map((e) => TeamsCard(teamMember: e)),
                                //! Fix to avoid non-scrollable state
                                Container(height: 200)
                              ],
                            ),
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
