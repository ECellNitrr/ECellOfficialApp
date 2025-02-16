import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/sponsor_head.dart';
import '../sponsors_head_repository.dart';

part 'sponsors_head_state.dart';

class SponsorsHeadCubit extends Cubit<SponsorsHeadState> {
  final SponsorsHeadRepository _sponsorsHeadRepository;
  SponsorsHeadCubit(this._sponsorsHeadRepository)
      : super(SponsorsHeadInitial());
  Future<void> getSponsorsHeadList() async {
    try {
      emit(SponsorsHeadLoading());
      List<SponsorHead> sponsHeadList =
          await _sponsorsHeadRepository.getAllSponsorsHead();
      emit(SponsorsHeadSuccess(sponsHeadList));
    } on NetworkException {
      emit(SponsorsHeadError(S.networkException));
    } on ValidationException catch (e) {
      emit(SponsorsHeadError(e.description));
    } on UnknownException {
      emit(SponsorsHeadError(S.unknownException));
    } catch (e) {
      Log.s(
          tag: "Sponsorhead Cubit",
          message: "Unknown Error message:" + e.toString());
    }
  }
}
