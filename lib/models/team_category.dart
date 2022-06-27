import 'package:ecellapp/models/team.dart';

/// Contains a list of <Team > and String position
class TeamCategory {
  final String category;
  List<TeamMember> members;

  TeamCategory(this.category, this.members);
}
