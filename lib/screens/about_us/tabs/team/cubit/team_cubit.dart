import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/team_category.dart';
import 'package:equatable/equatable.dart';

import '../team_repository.dart';

part 'team_state.dart';

class TeamCubit extends Cubit<TeamState> {
  final TeamRepository _teamRepository;
  TeamCubit(this._teamRepository) : super(TeamInitial());
  Future<void> getAllTeamMembers() async {
    try {
      emit(TeamLoading());
      List<TeamCategory> teamList = await _teamRepository.getAllTeamMembers();
      emit(TeamSuccess(teamList));
    } on NetworkException {
      emit(TeamError(S.networkException));
    } on ValidationException catch (e) {
      emit(TeamError(e.description));
    } on UnknownException {
      emit(TeamError(S.unknownException));
    } catch (e) {
      Log.s(tag: "TeamMember Cubit", message: "Unknown Error message:" + e.toString());
    }
  }
}
