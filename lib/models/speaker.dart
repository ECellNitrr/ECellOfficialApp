import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

class Speaker extends Equatable {
  //int
  final int id;
  final int year;
  final int experience;
  //String
  final String company;
  final String description;
  final String name;
  final String profilePic;
  final String socialMedia;

  Speaker({
    this.company,
    this.description,
    this.experience,
    this.id,
    this.name,
    this.profilePic,
    this.socialMedia,
    this.year,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json[S.speakerId] as int,
      year: json[S.speakerYear] as int,
      experience: json[S.speakerExperience] as int,
      name: json[S.speakerName] as String,
      company: json[S.speakerCompany] as String,
      profilePic: json[S.speakerProfilePic] as String,
      description: json[S.speakerDescription] as String,
      socialMedia: json[S.speakerSocialMedia] as String,
    );
  }

  @override
  List<Object> get props => [id];
}
