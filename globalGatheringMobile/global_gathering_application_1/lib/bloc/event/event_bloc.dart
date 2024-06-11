import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/bloc/comment/comment_bloc.dart';
import 'package:global_gathering_application_1/model/dto/new_event_dto.dart';
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
    on<DoGetMyEvent>(_onMyEvents);
    on<DoCreateEvent>(_onCreateEvent);
    on<GetEventListEvent>(_onFetchEventList);
  }

  void _onFetchEventList(
      GetEventListEvent event, Emitter<EventState> emit) async {
    try {
      final eventList = await _eventRepository.getEvents();
      emit(GetEventFetchSucess(eventList));
    } catch (e) {
      emit(GetEventError(e.toString()));
    }
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

  void _onMyEvents(GetEventEvent event, Emitter<EventState> emit) async {
    try {
      final eventList = await _eventRepository.getMyEvents();
      emit(GetEventFetchSucess(eventList));
    } catch (e) {
      emit(GetEventError(e.toString()));
    }
  }

  void _onCreateEvent(DoCreateEvent event, Emitter<EventState> emit) async {
    emit(GetEventFetchLoading());
    try {
      final AddAEvent addEvent = AddAEvent(
          name: event.name,
          descripcion: event.descripcion,
          url: event.url,
          latitude: event.latitude,
          longitude: event.longitude,
          price: event.price,
          ciudad: event.ciudad,
          date: event.selectedDate);
      final EventResponse eventResponse =
          await _eventRepository.createAevent(addEvent);
      emit(CreateEventSucess(eventResponse));
    } catch (e) {
      emit(GetEventError(e.toString()));
    }
  }
}
