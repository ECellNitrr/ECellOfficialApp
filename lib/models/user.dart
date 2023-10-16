import 'package:equatable/equatable.dart';

import '../core/res/strings.dart';

class User extends Equatable {
  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? phoneNumber;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });
  static User rtr(String f,String l,String e,String p){
    return User(firstName:f,lastName:l,email:e,phoneNumber: p);
  }
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json[S.firstnameKey] as String?,
      lastName: json[S.lastnameKey] as String?,
      email: json[S.emailKey] as String?,
      phoneNumber: json[S.phoneKey] as String?,
    );
  }

  @override
  List<Object?> get props => [email];
}
