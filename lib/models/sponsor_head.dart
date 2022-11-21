import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

const Map<String,dynamic> HeadContact = {
  "https://www.linkedin.com/in/jayant-kulharia-a426b41b9" :{
    "name" : "Jayant Kulharia",
    "email": "shubham1.kulharia@gmail.com",
    "phone": "7597903574"
  },
  "https://www.linkedin.com/in/tanishka-singh-83109b192" :{
    "name" : "Tanishka Singh",
    "email": "tanishkasingh.ts@gmail.com",
    "phone": "8800135090"
  },
  "https://in.linkedin.com/in/tajendra-singh-2726041bb" : {
    "name" : "Tajendra Singh",
    "email": "singhtajendra01@gmail.com",
    "phone": "7999499770"
  },
  "https://www.linkedin.com/in/shumelanaz2001": {
    "name" : "Shumela Naz",
    "email": "shumelanaz2001@gmail.com",
    "phone": "8827390404"
  },
  "https://www.linkedin.com/in/pandey-neeraj/": {
    "name" : "Neeraj Pandey",
    "email": "pandeyneeraj296@gmail.com",
    "phone": "6355322210"
  },
  "https://www.linkedin.com/in/samidha-thawait-90404518b":{
    "name" : "Samidha Thawait",
    "email": "samidha315@gmail.com",
    "phone": "6377471426"
  },
  "https://www.linkedin.com/in/aditya-dewangan-39420b190/" :{
    "name" : "Aditya Dewangan",
    "email": "dewanganaditya362@gmail.com",
    "phone": "7697935105"
  },
  "https://www.linkedin.com/in/prachi-soni-7ab896191": {
    "name" : "Prachi Soni",
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
    String? linkedin =json["linkedin"]as String?;
    return SponsorHead(
      id: json[S.teamId] as int?,
      type: json[S.teamMemberType] as String?,
      name: HeadContact[linkedin.toString()]["name"],
      phone: HeadContact[linkedin.toString()]["phone"],
      email: HeadContact[linkedin.toString()]["email"],
      linkedin: json["linkedin"]as String?,
      profilePic: json["image"] as String?,
    );
  }

  @override
  List<Object?> get props => [id];
}
