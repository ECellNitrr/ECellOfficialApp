import 'package:equatable/equatable.dart';

import '../core/res/strings.dart';

class User extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json[S.firstnameKey] as String,
      lastName: json[S.lastnameKey] as String,
      email: json[S.emailKey] as String,
      phoneNumber: json[S.phoneKey] as String,
    );
  }

  @override
  List<Object> get props => [email];
}
