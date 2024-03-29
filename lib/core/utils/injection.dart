import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:ecellapp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Service Locator Instance
final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  //! Core

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  final firebaseInit = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => firebaseInit);
}
