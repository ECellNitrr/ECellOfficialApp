import 'dart:convert';
import 'dart:math';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

abstract class LoginRepository {
  Future<String?> login(String email, String password);
}

class FakeLoginRepository implements LoginRepository {
  @override
  Future<String> login(String email, String password) async {
    // Simulate network delay

    await Future.delayed(Duration(seconds: 1));

    if (Random().nextBool()) {
      // random network error
      throw NetworkException();
    } else {
      // fake successful login
      return "Token 9935a8b04f2de7f5dec8f9e92a1893822b034dc7";
    }
  }
}
// We're moving login and signup portion to firebase completely due to repeated users in quiz (From firebase and API the same user)
class APILoginRepository implements LoginRepository {
  final String classTag = "APILoginRepository";
  @override
  Future<String?> login(String email, String password) async {
    final String tag = classTag + "login";
    http.Response response;
    try {
      response = await sl.get<http.Client>().post(
        Uri.parse(S.loginUrl),
        body: <String, dynamic>{S.emailKey: email, S.passwordKey: password},
      );
    } catch (e) {
      Log.e(tag: tag, message: "NetworkError:" + e.toString());
      throw NetworkException();
    }

    if (response.statusCode == 202) {
      try {
        String? token = json.decode(response.body)[S.tokenKey];
        print(token);
        return token;
      } catch (e) {
        Log.e(
            tag: tag,
            message: "Error while decoding response json to get token: $e");
        throw UnknownException();
      }
    } else if (response.statusCode == 400) {
      throw ValidationException(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw ResponseException(jsonDecode(response.body)['detail']);
    } else {
      Log.e(
          tag: tag,
          message:
              "Unknown response code -> ${response.statusCode}, message ->" +
                  response.body);
      throw UnknownException();
    }
  }
}
// Instead of token we will use email to check if user is already signed in
class FirebaseLoginRepository extends LoginRepository {
  @override
  Future<String?> login(String email, String password) async{
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      return email;
    }catch(e){
      print(e);
      throw ResponseException(e.toString());
    }
  }

}