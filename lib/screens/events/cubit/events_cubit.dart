import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/screens/events/events_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:ecellapp/models/event.dart';

part 'events_state.dart';

class EventsCubit extends Cubit<EventsState> {
  final EventsRepository _eventsRepository;
  final APIEventFormRepository _eventFormRepository;

  EventsCubit(this._eventsRepository, this._eventFormRepository) : super(EventsInitial());
  Future<void> getAllEvents() async {
    try {
      emit(EventsLoading());
      List<Event> json = await _eventsRepository.getAllEvents();
      Map<String, dynamic> forms = await _eventFormRepository.getAllEventForm();
      emit(EventsSuccess(json, forms));
    } on NetworkException {
      emit(EventsError(S.networkException));
    } on ValidationException catch (e) {
      emit(EventsError(e.description));
    } on UnknownException {
      emit(EventsError(S.unknownException));
    } catch (e) {
      Log.s(tag: "EventsCubit", message: "Weird Error. message ->" + e.toString());
    }
  }
}
