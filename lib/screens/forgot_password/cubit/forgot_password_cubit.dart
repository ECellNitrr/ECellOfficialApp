import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/screens/forgot_password/forgot_password_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../core/utils/logger.dart';
import 'package:ecellapp/core/res/strings.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepository _forgotPasswordRepository;

  ForgotPasswordCubit(this._forgotPasswordRepository) : super(ForgotEmailInitial());

  void sendOTP(String email, ForgotPasswordState state) async {
    try {
      emit(ForgotLoading());
      await _forgotPasswordRepository.sendOTP(email);
      emit(ForgotOTPInitial());
    } on NetworkException {
      emit(ForgotPasswordError(S.networkException, state));
    } on ResponseException catch (e) {
      emit(ForgotPasswordError(e.message, state));
    } catch (e) {
      Log.s(tag: "Weird exception", message: "Weird response message ->" + e);
    }
  }

  Future<void> checkOTP(String otp, ForgotPasswordState state, String email) async {
    emit(ForgotLoading());
    try {
      await _forgotPasswordRepository.checkOTP(otp, email);
      emit(ForgotResetInitial());
    } on NetworkException {
      emit(ForgotPasswordError(S.networkException, state));
    } on ResponseException catch (e) {
      emit(ForgotPasswordError(e.message, state));
    } catch (e) {
      Log.s(tag: "Weird exception", message: "Weird response message ->" + e);
    }
  }

  Future<void> changePassword(String email, String otp, String password, String confirmPassword,
      ForgotPasswordState state) async {
    emit(ForgotLoading());
    if (confirmPassword != password) {
      emit(ForgotPasswordError("Entered passwords do not match", state));
      return;
    }
    try {
      await _forgotPasswordRepository.changePassword(email, otp, password);
      emit(ForgotResetSuccess());
    } on NetworkException {
      emit(ForgotPasswordError(S.networkException, state));
    } on ResponseException catch (e) {
      emit(ForgotPasswordError(e.message, state));
    } catch (e) {
      Log.s(tag: "Weird exception", message: "Weird response message ->" + e);
    }
  }
}
