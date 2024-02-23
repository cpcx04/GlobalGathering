import 'package:global_gathering_application_1/model/reponse/event_response.dart';

abstract class EventRepository {
  Future<List<EventResponse>> getEvents();
  Future<String?> getTokenFromSharedPreferences();
}
