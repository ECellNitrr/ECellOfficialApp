part of 'leaderboard_cubit.dart';




abstract class LeaderState extends Equatable {
  const LeaderState();

  @override
  List<Object> get props => [];
}

class LeaderInitial extends LeaderState {
  const LeaderInitial();
}

class LeaderLoading extends LeaderState {
  const LeaderLoading();
}

class LeaderSuccess extends LeaderState {
  final List<Data> leaderList;

  const LeaderSuccess(this.leaderList);

  @override
  List<Object> get props => [leaderList];
}

class LeaderError extends LeaderState {
  final String message;

  const LeaderError(this.message);

  @override
  List<Object> get props => [message];
}
