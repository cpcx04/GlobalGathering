part of 'event_bloc.dart';

@immutable
sealed class GetEventEvent {}

class DoGetEventEvent extends GetEventEvent {
  final String events;
  DoGetEventEvent(this.events);
}
