import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/reponse/event_response.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<GetEventEvent, EventState> {
  final EventRepository _eventRepository;
  EventBloc(this._eventRepository) : super(EventInitial()) {
    on<GetEventEvent>(_onEventFetchList);
  }

  void _onEventFetchList(GetEventEvent event, Emitter<EventState> emit) async {
    try {
      final eventList = await _eventRepository.getEvents();
      emit(GetEventFetchSucess(eventList));
    } catch (e) {
      emit(GetEventError(e.toString()));
    }
  }
}
