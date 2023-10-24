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
  const EventsScreen({Key? key}) : super(key: key);

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
                  return _buildSuccess(context, state.json, state.eventForms);
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

  Widget _buildSuccess(BuildContext context, List<Event> eventsList, Map<String, dynamic> eventForms) {
    double ratio = MediaQuery.of(context).size.aspectRatio;
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).viewPadding.top;

    List<Widget> eventObjList = [];
    eventsList.forEach((element) => eventObjList.add(EventCard(event: element, eventForm: eventForms[element.name].toString(),)));

    return DefaultTextStyle.merge(
      style: GoogleFonts.roboto().copyWith(color: C.primaryUnHighlightedColor),
      child: Stack(
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: top + 40,
                ),
                Text(
                  "Events",
                  style: GoogleFonts.raleway(
                      fontSize: 55*height/1000,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5),
                ),
                Expanded(child: ListView(
                  padding: EdgeInsets.only(top: 10),
                  children: eventObjList)),
              ],
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
