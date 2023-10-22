import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/models/sponsor_category.dart';
import 'package:ecellapp/screens/sponser_new/sponsor_card.dart';
import 'package:ecellapp/screens/sponsors/sponsor_list.dart';
import 'package:ecellapp/screens/sponsors/sponsorship_head/sponsorship_head.dart';
import 'package:ecellapp/widgets/UI2023widgets/HomeScreen.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:ecellapp/widgets/rotated_curveed_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/res/strings.dart';
import '../../widgets/raisedButton.dart';
import 'cubit/sponsors_cubit.dart';

class SponsorsScreen extends StatelessWidget {
  const SponsorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // List<int> yearList = [2023, 2022];
    return StatefulWrapper(
      onInit: () => _getAllSponsors(context),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Container(
            padding: EdgeInsets.only(left: 10),
            child: BlocBuilder<SponsorsCubit, SponsorsState>(
              builder: (context, state) {
                Color color =
                    (state is SponsorsSuccess) ? Colors.black : Colors.white;
                return IconButton(
                  icon:
                      Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                );
              },
            ),
          ),
          // actions: [
          //   Container(
          //     width: width * 0.14,
          //     height: 50,
          //     // child: DropdownMenu<int>(
          //     //   inputDecorationTheme: InputDecorationTheme(
          //     //     isCollapsed: true,
          //     //     enabledBorder: InputBorder.none,
          //     //   ),
          //     //   textStyle: TextStyle(color: Colors.white),
          //     //   leadingIcon: Icon(
          //     //     Icons.keyboard_arrow_down_sharp,
          //     //     color: Colors.white,
          //     //   ),
          //     //   onSelected: ((value) {
          //     //     S.sponsorApiYear = value!;
          //     //     _getAllSponsors(context);
          //     //   }),
          //     //   initialSelection: yearList.first,
          //     //   dropdownMenuEntries:
          //     //       yearList.map<DropdownMenuEntry<int>>((int value) {
          //     //     return DropdownMenuEntry<int>(
          //     //         value: value, label: value.toString());
          //     //   }).toList(),
          //     // ),
          //   )
          // ],
        ),
        body: Stack(
          children: [
            ScreenBackground(elementId: 0),
            BlocBuilder<SponsorsCubit, SponsorsState>(
              builder: (context, state) {
                if (state is SponsorsInitial)
                  return _buildLoading(context);
                else if (state is SponsorsSuccess)
                  return _buildSuccess(context, state.sponsorsList);
                else if (state is SponsorsLoading)
                  return _buildLoading(context);
                else
                  return ReloadOnErrorWidget(() => _getAllSponsors(context));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<SponsorCategory> data) {
    double top = MediaQuery.of(context).viewPadding.top;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // ignore: close_sinks
    BehaviorSubject<int> subject = BehaviorSubject.seeded(0);

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
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
                    height: top + 40,
                  ),
                  Text(
                    "Sponsors",
                    style: GoogleFonts.raleway(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.only(top: 10),
                        itemCount: data.length,
                        itemBuilder: ((context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (data[index].spons.length > 0)
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
                              data[index].category != "Title"
                                  ? GridView.count(
                                      childAspectRatio: (0.8 / 1),
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: data[index].spons.length == 1
                                          ? EdgeInsets.symmetric(
                                              horizontal: width * 0.25,
                                              vertical: 5)
                                          : EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      crossAxisCount:
                                          data[index].spons.length == 1 ? 1 : 2,
                                      children: [
                                        ...data[index]
                                            .spons
                                            .map((e) => SponsorCard(sponsor: e))
                                      ],
                                    )
                                  : CarouselSlider.builder(
                                      itemCount: data[index].spons.length,
                                      itemBuilder: ((context, i, realIndex) {
                                        return SponsorCard(
                                          sponsor: data[index].spons[i],
                                        );
                                      }),
                                      options: CarouselOptions(
                                        height: height * 0.3,
                                        aspectRatio: 16 / 9,
                                        viewportFraction: 0.8,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 3),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        enlargeFactor: 0.3,
                                        scrollDirection: Axis.horizontal,
                                      ))
                            ],
                          );
                        })),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _getAllSponsors(BuildContext context) {
    final cubit = context.read<SponsorsCubit>();
    cubit.getSponsorsList();
  }
}
