import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/reponse/event_detail_response.dart';
import 'package:global_gathering_application_1/model/reponse/event_response.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<GetEventEvent, EventState> {
  final EventRepository _eventRepository;
  EventBloc(this._eventRepository) : super(EventInitial()) {
    on<DoGetEventEvent>(_onEventFetchList);
    on<DoAssignedEvent>(_onAssignedEvent);
  }

  void _onEventFetchList(GetEventEvent event, Emitter<EventState> emit) async {
    try {
      final eventList = await _eventRepository.getEvents();
      emit(GetEventFetchSucess(eventList));
    } catch (e) {
      emit(GetEventError(e.toString()));
    }
  }

  void _onAssignedEvent(GetEventEvent event, Emitter<EventState> emit) async {
    try {
      if (event is DoAssignedEvent) {
        final assignedEvent = await _eventRepository.assignAEvent(event.uuid);
        emit(AssigEventFetchSucess(assignedEvent));
      } else {
        emit(GetEventError("Invalid event type"));
      }
    } catch (e) {
      emit(GetEventError(e.toString()));
    }
  }
}
