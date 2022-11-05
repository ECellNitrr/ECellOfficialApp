import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

const Map<String,dynamic> HeadContact = {
  "Jayant kulharia":{
    "email": "shubham1.kulharia@gmail.com",
    "phone": "7597903574"
  },
  "Tanishka Singh":{
    "email": "tanishkasingh.ts@gmail.com",
    "phone": "8800135090"
  },
  "Tajendra Singh": {
    "email": "singhtajendra01@gmail.com",
    "phone": "7999499770"
  },
  "Shumela Naz": {
    "email": "shumelanaz2001@gmail.com",
    "phone": "8827390404"
  },
  "Neeraj Pandey": {
    "email": "pandeyneeraj296@gmail.com",
    "phone": "6355322210"
  },
  "Samidha Thawait":{
    "email": "samidha315@gmail.com",
    "phone": "6377471426"
  },
  "Aditya Dewangan":{
    "email": "dewanganaditya362@gmail.com",
    "phone": "7697935105"
  },
  "Prachi Soni": {
    "email": "prachisoninit19@gmail.com",
    "phone": "9399310967"
  },
};

class SponsorHead extends Equatable {
  //int
  final int? id;

  //String
  final String? type;
  final String? name;
  final String? phone;
  final String? email;
  final String? linkedin;
  final String? profilePic;

  SponsorHead({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.email,
    this.linkedin,
    this.profilePic,
  });

  factory SponsorHead.fromJson(Map<String, dynamic> json) {
    String? name =json[S.teamName] as String?;
    print(name);
    return SponsorHead(
      id: json[S.teamId] as int?,
      type: json[S.teamMemberType] as String?,
      name: name,
      phone: HeadContact[name.toString()]["phone"],
      email: HeadContact[name.toString()]["email"],
      linkedin: json["linkedin"]as String?,
      profilePic: json["image"] as String?,
    );
  }

  @override
  List<Object?> get props => [id];
}
