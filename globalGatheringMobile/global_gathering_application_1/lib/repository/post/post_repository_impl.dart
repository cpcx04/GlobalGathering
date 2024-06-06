import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:global_gathering_application_1/model/dto/post_dto.dart';
import 'package:global_gathering_application_1/model/reponse/post_response.dart';
import 'package:global_gathering_application_1/repository/post/post_repository.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class PostRepositoryImpl implements PostRepository {
  /*
  @override
  Future<PostResponse> newPost(PostDto postDto, File file) async {
    String? token = await getTokenFromSharedPreferences();

    var uri = Uri.parse('http://10.0.2.2:8080/new/post');
    //var request = http.MultipartRequest('POST', uri);
    //request.fields['post'] = jsonEncode(postDto.toJson());
    //request.files.add(await http.MultipartFile.fromPath('file', file.path));
    var formData = FormData.fromMap({
      'post': jsonEncode(postDto.toJson()),
      'file': await MultipartFile.fromFile(file, filename: file),
      'Authorization' : 'Bearer $token';
    });

    final response = await Dio().post(
        uri,
        data: formData,
      );
    /*request.headers['Authorization'] = 'Bearer $token';
    request.headers[HttpHeaders.acceptHeader] =
        'application/json; charset=utf-8';
    request.headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data';

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
*/
    
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      return PostResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to create post: ${response.body}');
    }
  }
*/
  @override
  Future<PostResponse> newPost(PostDto postDto, File file) async {
    String? token = await getTokenFromSharedPreferences();
    if (token == null) {
      throw Exception("Token not available");
    }

    var uri = 'http://10.0.2.2:8080/new/post';

    var formData = FormData.fromMap({
      'post': jsonEncode(postDto.toJson()),
      'file': await MultipartFile.fromFile(file.path,
          filename: file.path.split('/').last),
    });

    final dio = Dio();
    dio.options.headers = {
      'Authorization': 'Bearer ${token}',
      'Content-Type': 'multipart/form-data;'
    };
    final response = await dio.post(
      uri,
      data: formData,
    );

    if (response.statusCode == 201) {
      var jsonResponse = response.data;
      return PostResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to create post: ${response.data}');
    }
  }

  Future<String?> getTokenFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  @override
  Future<List<PostResponse>> getMyPosts() async {
    String? token = await getTokenFromSharedPreferences();
    if (token == null) {
      throw Exception("Token not available");
    }

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    List<PostResponse> postList = [];

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      postList = responseData
          .map((eventJson) => PostResponse.fromJson(eventJson))
          .toList();
    }
    return postList;
  }
}
