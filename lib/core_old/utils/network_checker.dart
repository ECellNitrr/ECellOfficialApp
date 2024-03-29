import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';

// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// /// Abstract Utility class to check internet connection by opening
// /// a socket to a list of specific address each with individual port and timeout.
class Connection {
  final DataConnectionChecker connectionChecker;

  Connection(this.connectionChecker);

  Future<bool> get check => connectionChecker.hasConnection;
}
