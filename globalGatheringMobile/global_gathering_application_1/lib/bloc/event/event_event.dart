part of 'event_bloc.dart';

@immutable
sealed class GetEventEvent {}

class GetEventListEvent extends GetEventEvent {
  final String events;
  GetEventListEvent(this.events);
}

class DoGetEventEvent extends GetEventEvent {
  final String events;
  DoGetEventEvent(this.events);
}

class DoAssignedEvent extends GetEventEvent {
  final String uuid;
  DoAssignedEvent(this.uuid);
}

class DoGetMyEvent extends GetEventEvent {
  final String events;
  DoGetMyEvent(this.events);
}

class DoCreateEvent extends GetEventEvent {
  final String name;
  final String descripcion;
  final String url;
  final double latitude;
  final double longitude;
  final double price;
  final String ciudad;
  final DateTime selectedDate;
  DoCreateEvent(this.name, this.descripcion, this.url, this.latitude,
      this.longitude, this.price, this.ciudad, this.selectedDate);
}
