import 'dart:math';

import 'package:http/http.dart' as http;

import '../../core/res/errors.dart';
import '../../core/res/strings.dart';
import '../../core/utils/injection.dart';
import '../../core/utils/logger.dart';

abstract class SignupRepository {
  /// Takes in `firstName`, `lastName`, `email`, `mobileNumber` and `password` , registers the user and throws a suitable exception if something goes wrong.
  Future<void> signup(
      String firstName, String lastName, String email, String mobileNumber, String password);
}

class FakeSignupRepository implements SignupRepository {
  @override
  Future<void> signup(
      String firstName, String lastName, String email, String mobileNumber, String password) async {
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
  Future<void> signup(
      String firstName, String lastName, String email, String mobileNumber, String password) async {
    final String tag = classTag + "signup";
    http.Response response;
    try {
      response = await sl.get<http.Client>().post(
        S.registerUrl,
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
      return true;
    } else if (response.statusCode == 400) {
      throw ValidationException(response.body);
    } else {
      Log.s(
          tag: tag,
          message: "Unknown response code -> ${response.statusCode}, message ->" + response.body);
      throw UnknownException();
    }
  }
}
