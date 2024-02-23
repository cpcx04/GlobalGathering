import 'dart:convert';

import 'package:global_gathering_application_1/model/reponse/event_response.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<List<EventResponse>> getEvents() async {
    String? token = await getTokenFromSharedPreferences();

    if (token == null) {
      throw Exception("Token not available");
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/event/allEvents'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    List<EventResponse> eventList = [];

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      eventList = responseData
          .map((eventJson) => EventResponse.fromJson(eventJson))
          .toList();
    }
    return eventList;
  }

  @override
  Future<String?> getTokenFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
