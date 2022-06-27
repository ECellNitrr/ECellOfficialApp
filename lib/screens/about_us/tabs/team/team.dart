import 'package:ecellapp/core/res/dimens.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:ecellapp/widgets/reload_on_error.dart';
import 'package:ecellapp/widgets/screen_background.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecellapp/widgets/stateful_wrapper.dart';

import 'cubit/team_cubit.dart';

class TeamScreen extends StatelessWidget {
  const TeamScreen({Key key}) : super(key: key);

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
              icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
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
                  return _buildLoading();
                else if (state is TeamSuccess)
                  return _buildSuccess(context, state.teamList);
                else if (state is TeamLoading)
                  return _buildLoading();
                else
                  return ReloadOnErrorWidget(() => _getAllTeamMembers(context));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, List<TeamCategory> teamList) {
    //TODO: UI
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(teamList[6].category, textAlign: TextAlign.center),
          Text(teamList[6].members[0].name, textAlign: TextAlign.center),
          Text(teamList[1].category, textAlign: TextAlign.center),
          Text(teamList[1].members[0].name, textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void _getAllTeamMembers(BuildContext context) {
    final cubit = context.read<TeamCubit>();
    cubit.getAllTeamMembers();
  }
}
