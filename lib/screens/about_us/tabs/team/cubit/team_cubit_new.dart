import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:ecellapp/screens/about_us/tabs/team/cubit/team_cubit.dart';
import 'package:ecellapp/screens/about_us/tabs/team/team_repository_new.dart';
import 'package:equatable/equatable.dart';


part 'team_state_new.dart';

class TeamCubitNew extends Cubit<TeamStateNew> {
  final TeamRepositoryNew _teamRepositoryNew;
  TeamCubitNew(this._teamRepositoryNew) : super(TeamInitial());
  Future<void> getAllTeamMembers() async {
    try {
      emit(TeamLoading());
      List<TeamCategory> teamList = await _teamRepositoryNew.getAllTeamMembers();
      emit(TeamSuccess(teamList));
    } on NetworkException {
      emit(TeamError(S.networkException));
    } on ValidationException catch (e) {
      emit(TeamError(e.description));
    } on UnknownException {
      emit(TeamError(S.unknownException));
    } catch (e) {
      Log.s(
          tag: "TeamMember Cubit",
          message: "Unknown Error message:" + e.toString());
    }
  }
}
