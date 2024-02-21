import 'package:global_gathering_application_1/model/dto/login_dto.dart';
import 'package:global_gathering_application_1/model/dto/register_dto.dart';
import 'package:global_gathering_application_1/model/reponse/register_reponse.dart';

abstract class AuthRepository {
  Future<RegisterReponse> login(LoginDto loginDto);
  Future<RegisterReponse> register(RegisterDto registerDto);
}
