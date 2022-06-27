import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/models/sponsor_category.dart';
import 'package:ecellapp/screens/sponsors/sponsor_card.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:ecellapp/widgets/rotated_curveed_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';
import 'cubit/sponsors_cubit.dart';

class SponsorsScreen extends StatelessWidget {
  const SponsorsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Color color = (state is SponsorsSuccess) ? Colors.black : Colors.white;
                return IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: color, size: 30),
                  onPressed: () => Navigator.of(context).pop(),
                );
              },
            ),
          ),
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

    // ignore: close_sinks
    BehaviorSubject<int> subject = BehaviorSubject.seeded(0);

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: Container(
          color: Colors.white,
          child: StreamBuilder<int>(
            initialData: 0,
            stream: subject.stream,
            builder: (context, snapshot) {
              int i = snapshot.data;
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 40, top: 80),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: data.map((spon) {
                            String tab = spon.category;
                            return RotatedCurvedTile(
                              checked: tab == data[i].category,
                              name: tab,
                              onTap: () => subject.add(data.indexWhere((e) => e.category == tab)),
                            );
                          }).toList(),
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
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: top + 56),
                              Text(
                                "Sponsors",
                                style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              ...data[i].spons.map((e) => SponsorCard(sponsor: e)),
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

  void _getAllSponsors(BuildContext context) {
    final cubit = context.read<SponsorsCubit>();
    cubit.getSponsorsList();
  }
}
