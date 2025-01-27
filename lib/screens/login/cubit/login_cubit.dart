import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/screens/login/login.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/res/errors.dart';
import '../../../core/res/strings.dart';
import '../login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;
  LoginCubit(this._loginRepository) : super(LoginInitial());
  // static String? Token;
 static String? mailToken;
  Future<void> login(String email, String password) async {
    try {
      emit(LoginLoading());
      String? token = await (_loginRepository.login(email, password));
      mailToken=token;
      print("printing mail token");
      print(token);
      await sl
          .get<SharedPreferences>()
          .setString(S.mailTokenKey, token!);//Take care of exception prefixes for shared preferences
      await sl
      .get<SharedPreferences>()
      .setString('email', token!);
      emit(LoginSuccess(token));
    } on NetworkException {
      emit(LoginError(S.networkException));
    } on ValidationException catch (e) {
      emit(LoginError(e.description));
    } on ResponseException catch (e) {
      emit(LoginError(e.message));
    }
  }
}
