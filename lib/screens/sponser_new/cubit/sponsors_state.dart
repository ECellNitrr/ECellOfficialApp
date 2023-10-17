part of 'sponsors_cubit.dart';

abstract class SponsorsState extends Equatable {
  const SponsorsState();

  @override
  List<Object> get props => [];
}

class SponsorsInitial extends SponsorsState {
  const SponsorsInitial();
}

class SponsorsLoading extends SponsorsState {
  const SponsorsLoading();
}

class SponsorsSuccess extends SponsorsState {
  final List<SponsorCategory> sponsorsList;
  const SponsorsSuccess(this.sponsorsList);
  @override
  List<Object> get props => [sponsorsList];
}

class SponsorsError extends SponsorsState {
  final String message;
  const SponsorsError(this.message);
  @override
  List<Object> get props => [message];
}
