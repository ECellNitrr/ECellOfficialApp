part of 'events_cubit.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

class EventsInitial extends EventsState {
  const EventsInitial();
}

class EventsLoading extends EventsState {
  const EventsLoading();
}

class EventsSuccess extends EventsState {
  final List<Event> json;
  final Map<String, dynamic> eventForms;
  const EventsSuccess(this.json, this.eventForms);
  @override
  List<Object> get props => [json];
}

class EventsError extends EventsState {
  final String message;
  const EventsError(this.message);
  @override
  List<Object> get props => [message];
}
