import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/res/errors.dart';
import '../../core/res/strings.dart';
import '../../core/utils/injection.dart';
import '../../core/utils/logger.dart';

abstract class SignupRepository {
  /// Takes in `firstName`, `lastName`, `email`, `mobileNumber` and `password` , registers the user and throws a suitable exception if something goes wrong.
  Future<void> signup(String firstName, String lastName, String email,
      String mobileNumber, String password);
}

class FakeSignupRepository implements SignupRepository {
  @override
  Future<void> signup(String firstName, String lastName, String email,
      String mobileNumber, String password) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    if (Random().nextBool()) {
      // random network error
      throw NetworkException();
    } else {
      // fake successful login
      return;
    }
  }
}

class APISignupRepository implements SignupRepository {
  final String classTag = "APILoginRepository";
  @override
  Future<void> signup(String firstName, String lastName, String email,
      String mobileNumber, String password) async {
    final String tag = classTag + "signup";
    http.Response response;
    try {
      response = await sl.get<http.Client>().post(
        Uri.parse(S.registerUrl),
        body: <String, dynamic>{
          S.firstnameKey: firstName,
          S.lastnameKey: lastName,
          S.emailKey: email,
          S.phoneKey: mobileNumber,
          S.passwordKey: password
        },
      );
    } catch (e) {
      Log.e(tag: tag, message: "NetworkError:" + e.toString());
      throw NetworkException();
    }

    if (response.statusCode == 201) {
      // return true;
      return;
    } else if (response.statusCode == 400) {
      throw ValidationException(response.body);
    } else {
      Log.s(
          tag: tag,
          message:
              "Unknown response code -> ${response.statusCode}, message ->" +
                  response.body);
      throw UnknownException();
    }
  }
}
//Migrating to firebase Email and password SignUp
class FirebaseSignUpRepository extends SignupRepository{
  @override
  Future<void> signup(String firstName, String lastName, String email, String mobileNumber, String password) async{
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await sl.get<SharedPreferences>().setString(S.firstName, firstName);
      await sl.get<SharedPreferences>().setString(S.lastName, lastName);
      await sl.get<SharedPreferences>().setString(S.email, email);
      await sl.get<SharedPreferences>().setString(S.phone, mobileNumber);
      await sl.get<SharedPreferences>().setString(S.mailTokenKey, email);
    }catch (e){
      print(e);
      throw ResponseException(e.toString());
    }
  }

}
