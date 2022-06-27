import 'dart:convert';
import 'dart:math';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/injection.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:http/http.dart' as http;

abstract class LoginRepository {
  /// Takes in login credentials (here id and password)
  /// Use by implementing this class
  Future<String> login(String email, String password);
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

class APILoginRepository implements LoginRepository {
  final String classTag = "APILoginRepository";
  @override
  Future<String> login(String email, String password) async {
    final String tag = classTag + "login";
    http.Response response;
    try {
      response = await sl.get<http.Client>().post(
        S.loginUrl,
        body: <String, dynamic>{S.emailKey: email, S.passwordKey: password},
      );
    } catch (e) {
      Log.e(tag: tag, message: "NetworkError:" + e.toString());
      throw NetworkException();
    }

    if (response.statusCode == 202) {
      try {
        String token = json.decode(response.body)[S.tokenKey];
        return token;
      } catch (e) {
        Log.e(tag: tag, message: "Error while decoding response json to get token: $e");
        throw UnknownException();
      }
    } else if (response.statusCode == 400) {
      throw ValidationException(response.body);
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw ResponseException(jsonDecode(response.body)['detail']);
    } else {
      Log.e(
          tag: tag,
          message: "Unknown response code -> ${response.statusCode}, message ->" + response.body);
      throw UnknownException();
    }
  }
}
