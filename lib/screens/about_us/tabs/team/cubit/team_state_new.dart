part of 'team_cubit_new.dart';

abstract class TeamStateNew extends Equatable {
  const TeamStateNew();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamStateNew {
  const TeamInitial();
}

class TeamLoading extends TeamStateNew {
  const TeamLoading();
}

class TeamSuccess extends TeamStateNew {
  final List<TeamCategory>teamList;

  const TeamSuccess(this.teamList);

  @override
  List<Object> get props => [teamList];
}

class TeamError extends TeamStateNew {
  final String message;

  const TeamError(this.message);

  @override
  List<Object> get props => [message];
}
