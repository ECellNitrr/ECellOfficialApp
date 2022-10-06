import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/leader_board.dart';

import 'package:equatable/equatable.dart';

import '../leaderboard_repository.dart';


part 'leaderboard_state.dart';

class LeaderCubit extends Cubit<LeaderState> {
  final LeaderRepository _LeaderRepository;
  LeaderCubit(this._LeaderRepository) : super(LeaderInitial());
  Future<void> getLeaderList() async {
    try {
      emit(LeaderLoading());
      List<Data> LeaderList = await _LeaderRepository.getAllleaders();
      emit(LeaderSuccess(LeaderList));
    } on NetworkException {
      emit(LeaderError(S.networkException));
    } on ValidationException catch (e) {
      emit(LeaderError(e.description));
    } on UnknownException {
      emit(LeaderError(S.unknownException));
    } catch (e) {
      Log.s(tag: "Leader Cubit", message: "Unknown Error message:" + e.toString());
    }
  }
}
