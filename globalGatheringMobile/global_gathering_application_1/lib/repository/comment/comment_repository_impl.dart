import 'dart:convert';

import 'package:global_gathering_application_1/model/reponse/comment_response.dart';
import 'package:global_gathering_application_1/repository/comment/comment_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CommentRepositoryImpl implements CommentRepository {
  @override
  Future<List<CommentResponse>> getComments() async {
    String? token = await getTokenFromSharedPreferences();

    if (token == null) {
      throw Exception("Token not available");
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/comments/singleComments'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    List<CommentResponse> commentList = [];

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      commentList = responseData
          .map((eventJson) => CommentResponse.fromJson(eventJson))
          .toList();
    }
    return commentList;
  }

  Future<String?> getTokenFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }
}
