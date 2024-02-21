import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/dto/register_dto.dart';
import 'package:global_gathering_application_1/model/reponse/register_reponse.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  RegisterBloc(this.authRepository) : super(RegisterInitial()) {
    on<DoRegisterEvent>(_doRegister);
  }

  void _doRegister(DoRegisterEvent event, Emitter<RegisterState> emit) async {
    emit(DoRegisterLoading());
    final SharedPreferences prefs = await _prefs;
    try {
      final RegisterDto registerDto = RegisterDto(
          username: event.registerDto.username,
          fullName: event.registerDto.fullName,
          password: event.registerDto.password,
          verifyPassword: event.registerDto.verifyPassword,
          email: event.registerDto.email);
      final RegisterReponse registerReponse =
          await authRepository.register(registerDto);
      emit(DoRegisterSuccess(registerReponse));
      prefs.setString("token", registerReponse.token!);
    } catch (e) {
      emit(DoRegisterError(e.toString()));
    }
  }
}
