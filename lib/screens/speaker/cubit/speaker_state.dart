part of 'speaker_cubit.dart';

abstract class SpeakerState extends Equatable {
  const SpeakerState();

  @override
  List<Object> get props => [];
}

class SpeakerInitial extends SpeakerState {
  const SpeakerInitial();
}

class SpeakerLoading extends SpeakerState {
  const SpeakerLoading();
}

class SpeakerSuccess extends SpeakerState {
  final List<Speaker> speakerList;
  const SpeakerSuccess(this.speakerList);
  @override
  List<Object> get props => [speakerList];
}

class SpeakerError extends SpeakerState {
  final String message;
  const SpeakerError(this.message);
  @override
  List<Object> get props => [message];
}
