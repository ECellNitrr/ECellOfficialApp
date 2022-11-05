part of 'sponsors_head_cubit.dart';


abstract class SponsorsHeadState extends Equatable {
  const SponsorsHeadState();

  @override
  List<Object> get props => [];
}

class SponsorsHeadInitial extends SponsorsHeadState {
  const SponsorsHeadInitial();
}

class SponsorsHeadLoading extends SponsorsHeadState {
  const SponsorsHeadLoading();
}

class SponsorsHeadSuccess extends SponsorsHeadState {
  final List<SponsorHead> sponsorsHeadList;
  const SponsorsHeadSuccess(this.sponsorsHeadList);
  @override
  List<Object> get props => [sponsorsHeadList];
}

class SponsorsHeadError extends SponsorsHeadState {
  final String message;
  const SponsorsHeadError(this.message);
  @override
  List<Object> get props => [message];
}
