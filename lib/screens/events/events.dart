import 'package:ecellapp/core/res/colors.dart';
import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/models/event.dart';
import 'package:ecellapp/screens/events/cubit/events_cubit.dart';
import 'package:ecellapp/widgets/ecell_animation.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'events_card.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () => _getAllEvents(context),
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
        ),
        body: Stack(
          children: [
            ScreenBackground(elementId: 0),
            BlocBuilder<EventsCubit, EventsState>(
              builder: (context, state) {
                if (state is EventsInitial)
                  return _buildLoading(context);
                else if (state is EventsSuccess)
                  return _buildSuccess(context, state.json);
                else if (state is EventsLoading)
                  return _buildLoading(context);
                else
                  return ReloadOnErrorWidget(() => _getAllEvents(context));
              },
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

  Widget _buildSuccess(BuildContext context, List<Event> eventsList) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double top = MediaQuery.of(context).viewPadding.top;

    List<Widget> eventObjList = [];
    eventsList.forEach((element) => eventObjList.add(EventCard(event: element)));

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowGlow();
              return true;
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.only(top: top + 56),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "Events",
                      style: TextStyle(
                        fontSize: ratio > 0.5 ? 45 : 50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Column(children: eventObjList),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getAllEvents(BuildContext context) {
    final cubit = context.read<EventsCubit>();
    cubit.getAllEvents();
  }
}
