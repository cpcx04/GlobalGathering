part of 'event_bloc.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}

final class GetEventDetail extends EventState {}

final class GetEventFetchLoading extends EventState {}

final class GetEventFetchSucess extends EventState {
  final List<EventResponse> event;
  GetEventFetchSucess(this.event);
}

final class GetEventError extends EventState {
  final String message;
  GetEventError(this.message);
}
