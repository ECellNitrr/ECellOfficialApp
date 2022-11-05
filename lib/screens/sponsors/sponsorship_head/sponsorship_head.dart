import 'package:ecellapp/models/sponsor_head.dart';
import 'package:ecellapp/screens/sponsors/cubit/sponsors_cubit.dart';
import 'package:ecellapp/screens/sponsors/sponsorship_head/sponsor_head_card.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';

import 'cubit/sponsors_head_cubit.dart';

class SponsorsHeadScreen extends StatelessWidget {
  SponsorsHeadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllSponsorHead(context),
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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [C.backgroundTop1, C.backgroundBottom1],
            ),
          ),
          child: BlocBuilder<SponsorsHeadCubit,SponsorsHeadState>(
            builder: (context, state) {
              if (state is SponsorsHeadInitial)
                return _buildLoading(context);
              else if (state is SponsorsHeadSuccess)
                return _buildSuccess(context, state.sponsorsHeadList);
              else if (state is SponsorsHeadLoading)
                return _buildLoading(context);
              else
                return ReloadOnErrorWidget(() => _getAllSponsorHead(context));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<SponsorHead> sponsorsHeadList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;

    List<Widget> sponsorHeadContentList = [];
    sponsorsHeadList.forEach((element) => sponsorHeadContentList.add(SponsorHeadCard(sponsorHead: element)));

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sponsorship",
                  style: TextStyle(
                    fontSize: ratio > 0.5 ? 30 : 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Head Co-ordinators",
                  style: TextStyle(
                    fontSize: ratio > 0.5 ? 28 : 38,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(children: sponsorHeadContentList),
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

  void _getAllSponsorHead(BuildContext context) {
    final cubit = context.read<SponsorsHeadCubit>();
    cubit.getSponsorsHeadList();
  }
}
