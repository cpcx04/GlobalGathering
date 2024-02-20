import 'package:global_gathering_application_1/model/dto/login_dto.dart';
import 'package:global_gathering_application_1/model/reponse/login/login_response.dart';
import 'package:global_gathering_application_1/model/reponse/token/request_token_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
  Future<RequestTokenResponse> getRequestToken();
}
