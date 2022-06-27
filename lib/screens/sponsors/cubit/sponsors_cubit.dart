import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/sponsor_category.dart';
import 'package:ecellapp/screens/sponsors/sponsors_repository.dart';
import 'package:equatable/equatable.dart';

part 'sponsors_state.dart';

class SponsorsCubit extends Cubit<SponsorsState> {
  final SponsorsRepository _sponsorsRepository;
  SponsorsCubit(this._sponsorsRepository) : super(SponsorsInitial());
  Future<void> getSponsorsList() async {
    try {
      emit(SponsorsLoading());
      List<SponsorCategory> speakerList = await _sponsorsRepository.getAllSponsors();
      emit(SponsorsSuccess(speakerList));
    } on NetworkException {
      emit(SponsorsError(S.networkException));
    } on ValidationException catch (e) {
      emit(SponsorsError(e.description));
    } on UnknownException {
      emit(SponsorsError(S.unknownException));
    } catch (e) {
      Log.s(tag: "Speaker Cubit", message: "Unknown Error message:" + e.toString());
    }
  }
}
