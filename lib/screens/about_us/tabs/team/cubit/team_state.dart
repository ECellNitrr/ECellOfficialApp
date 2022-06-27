part of 'team_cubit.dart';

abstract class TeamState extends Equatable {
  const TeamState();

  @override
  List<Object> get props => [];
}

class TeamInitial extends TeamState {
  const TeamInitial();
}

class TeamLoading extends TeamState {
  const TeamLoading();
}

class TeamSuccess extends TeamState {
  final List<TeamCategory> teamList;

  const TeamSuccess(this.teamList);

  @override
  List<Object> get props => [teamList];
}

class TeamError extends TeamState {
  final String message;

  const TeamError(this.message);

  @override
  List<Object> get props => [message];
}
