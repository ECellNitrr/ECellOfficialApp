import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/res/errors.dart';
import '../../../core/res/strings.dart';
import '../../../core/utils/logger.dart';
import '../../../models/user.dart';
import '../splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _splashRepository;
  SplashCubit(this._splashRepository) : super(SplashLoading());

  Future<void> getProfile() async {
    try {
      emit(SplashLoading());
      User user = await _splashRepository.getProfile();
      emit(SplashSuccess(user));
    } on NetworkException {
      emit(SplashError(S.networkException));
    } on ValidationException catch (e) {
      emit(SplashError(e.description));
    } on UnknownException {
      emit(SplashError(S.unknownException));
    } catch (e) {
      Log.s(tag: "SplashCubit", message: "Weird Error. message ->" + e.toString());
    }
  }
}
