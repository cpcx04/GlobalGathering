import 'dart:convert';

import 'package:global_gathering_application_1/model/dto/login_dto.dart';
import 'package:global_gathering_application_1/model/dto/register_dto.dart';
import 'package:global_gathering_application_1/model/reponse/register_reponse.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  final String baseUrl = 'http://localhost:8080';

  @override
  Future<RegisterReponse> login(LoginDto loginDto) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/auth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(loginDto.toJson()),
    );

    if (response.statusCode == 201) {
      return RegisterReponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<void> register(RegisterDto registerDto) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerDto.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }
}
