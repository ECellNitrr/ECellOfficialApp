import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

class Data extends Equatable {
  String username;
  String phone;
  int bquizScore;

  Data({
    required this.username,
    required this.phone,
    required this.bquizScore,
  });

  // factory Data.fromJson(Map<String, dynamic> json) {
  //   return Data(
  //     username: json['username'] as String,
  //     phone: json['phone'] as String,
  //     bquizScore: json['bquiz_score'] as int,
  //   );
  // }

  factory Data.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return Data(
      username: data["username"],
      phone: data["phone"],
      bquizScore: data["score"],
    );
  }

  @override
  List<Object> get props => throw UnimplementedError();
}