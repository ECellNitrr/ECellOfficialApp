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

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      username: json['username'] as String,
      email: json['email'] as String,
      bquizScore: json['bquiz_score'] as int,
    );
  }
  
  @override
  List<Object> get props => throw UnimplementedError();

  
}
