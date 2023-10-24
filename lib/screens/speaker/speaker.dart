import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/models/speaker.dart';
import 'package:ecellapp/screens/speaker/cubit/speaker_cubit.dart';
import 'package:ecellapp/screens/speaker/speaker_card.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';

import '../../core/res/strings.dart';

class SpeakerScreen extends StatelessWidget {
  SpeakerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllSpeakers(context),
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
              colors: [C.backgroundTop, C.backgroundBottom],
            ),
          ),
          child: BlocBuilder<SpeakerCubit, SpeakerState>(
            builder: (context, state) {
              if (state is SpeakerInitial)
                return _buildLoading(context);
              else if (state is SpeakerSuccess)
                return _buildSuccess(context, state.speakerList);
              else if (state is SpeakerLoading)
                return _buildLoading(context);
              else
                return ReloadOnErrorWidget(() => _getAllSpeakers(context));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<Speaker> speakerList) {
    double top = MediaQuery.of(context).viewInsets.top;
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Widget> speakerContentList = [];
    speakerList.forEach((element) => speakerContentList.add(SpeakerCard(speaker: element)));

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
              EdgeInsets.fromLTRB(width * 0.1, height * 0.3, 0.0, 0.0),
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
              children: <Widget>[
                SizedBox(
                  height: top + 40,
                ),
                Text(
                  "Speakers",
                  style: GoogleFonts.raleway(
                      fontSize: ratio > 0.5 ? 37 : 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5),
                ),
                Expanded(child: (speakerList.length!=0)?ListView(
                  padding: EdgeInsets.only(top: 10),
                  children: speakerContentList,
                ):Center(
                  child: Text(
                    "Will be updated Soon...",
                    style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5),
                  ),
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Center(child: ECellLogoAnimation(size: width / 2));
  }

  void _getAllSpeakers(BuildContext context) {
    final cubit = context.read<SpeakerCubit>();
    cubit.getSpeakerList();
  }
}
