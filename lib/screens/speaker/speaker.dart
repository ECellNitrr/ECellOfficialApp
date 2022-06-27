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

class SpeakerScreen extends StatelessWidget {
  SpeakerScreen({Key key}) : super(key: key);

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
              colors: [C.backgroundTop1, C.backgroundBottom1],
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

    List<Widget> speakerContentList = [];
    speakerList.forEach((element) => speakerContentList.add(SpeakerCard(speaker: element)));

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(top: top + 56),
            child: Column(
              children: <Widget>[
                Text(
                  "Speakers",
                  style: TextStyle(
                    fontSize: ratio > 0.5 ? 45 : 50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(children: speakerContentList),
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

  void _getAllSpeakers(BuildContext context) {
    final cubit = context.read<SpeakerCubit>();
    cubit.getSpeakerList();
  }
}
