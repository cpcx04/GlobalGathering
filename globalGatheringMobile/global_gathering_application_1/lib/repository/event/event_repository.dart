import 'package:global_gathering_application_1/model/reponse/event_detail_response.dart';
import 'package:global_gathering_application_1/model/reponse/event_response.dart';

abstract class EventRepository {
  Future<List<EventResponse>> getEvents();
  Future<EventDetailResponse> assignAEvent(String uuid);
  Future<List<EventResponse>> getMyEvents();
  Future<String?> getTokenFromSharedPreferences();
}
