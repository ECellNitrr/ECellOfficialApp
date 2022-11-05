import 'package:ecellapp/core/res/strings.dart';
import 'package:equatable/equatable.dart';

class TeamMember extends Equatable {
  //int
  final int? id;

  //String
  final String? type;
  final String? name;
  final String? image;
  final String? linkedin;
  final String? facebook;
  final String? profilePic;

  TeamMember({
    this.id,
    this.type,
    this.name,
    this.image,
    this.linkedin,
    this.facebook,
    this.profilePic,
  });

  factory TeamMember.fromJson(Map<String, dynamic> json) {
    return TeamMember(
      id: json[S.teamId] as int?,
      type: json[S.teamMemberType] as String?,
      name: json[S.teamName] as String?,
      image:json["image"] as String?,
      linkedin:json["linkedin"] as String?,
      facebook:json["facebook"] as String?,
      profilePic: json[S.teamProfilePic] as String?,
    );
  }

  @override
  List<Object?> get props => [id];
}
