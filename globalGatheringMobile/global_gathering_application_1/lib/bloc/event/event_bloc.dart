import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<GetEventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<GetEventEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
