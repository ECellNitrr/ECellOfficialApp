import 'dart:ffi';

import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

class Data extends Equatable {
  
  String username;
  String email;
  int bquizScore;

  Data({
    required this.username,
    required this.email,
    required this.bquizScore,
  });

  // factory Data.fromJson(Map<String, dynamic> json) {
  //   return Data(
  //     username: json['username'] as String,
  //     email: json['email'] as String,
  //     bquizScore: json['bquiz_score'] as int,
  //   );
  // }

  factory Data.fromFirestore(Map<String, dynamic> data) {
    return Data(
        username :data["username"],
        email: data["email"],
        bquizScore: data["score"] ,
        
    );
  }
  
  @override
  List<Object> get props => throw UnimplementedError();

  
}