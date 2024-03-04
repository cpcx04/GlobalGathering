import 'dart:convert';

import 'package:global_gathering_application_1/model/dto/new_event_dto.dart';
import 'package:global_gathering_application_1/model/reponse/event_detail_response.dart';
import 'package:global_gathering_application_1/model/reponse/event_response.dart';
import 'package:global_gathering_application_1/repository/event/event_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EventRepositoryImpl implements EventRepository {
  //obtener los eventos
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

//Obtener Token
  @override
  Future<String?> getTokenFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

//Asignar un evento a un cliente
  @override
  Future<EventDetailResponse> assignAEvent(String uuid) async {
    String? token = await getTokenFromSharedPreferences();

    if (token == null) {
      throw Exception("Token not available");
    }

    final response = await http.put(
      Uri.parse('http://10.0.2.2:8080/event/apuntar/me/$uuid'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return EventDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to assign participant');
    }
  }

//Obtener mis eventos
  @override
  Future<List<EventResponse>> getMyEvents() async {
    String? token = await getTokenFromSharedPreferences();

    if (token == null) {
      throw Exception("Token not available");
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/event/get/assigned'),
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
  Future<EventResponse> createAevent(AddAEvent event) async {
    String? token = await getTokenFromSharedPreferences();

    if (token == null) {
      throw Exception("Token not available");
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/event/new'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(event.toJson()),
    );

    if (response.statusCode == 201) {
      return EventResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create the event');
    }
  }
}
