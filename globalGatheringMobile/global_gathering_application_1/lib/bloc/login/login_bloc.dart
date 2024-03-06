import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/dto/login_dto.dart';
import 'package:global_gathering_application_1/model/reponse/register_reponse.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  LoginBloc(this.authRepository) : super(LoginInitial()) {
    on<DoLoginEvent>(_doLogin);
  }

  void _doLogin(DoLoginEvent event, Emitter<LoginState> emit) async {
    emit(DoLoginLoading());
    final SharedPreferences prefs = await _prefs;

    try {
      final LoginDto loginDto = LoginDto(
        username: event.username,
        password: event.password,
      );

      final RegisterReponse registerReponse =
          await authRepository.login(loginDto);

      if (registerReponse.token != null &&
          registerReponse.id != null &&
          registerReponse.username != null) {
        emit(DoLoginSuccess(registerReponse));

        prefs.setString("token", registerReponse.token!);
        prefs.setString("uuid", registerReponse.id!);
        prefs.setString("username", registerReponse.username!);
        prefs.setString("email", registerReponse.email!);
        prefs.setString("name", registerReponse.nombre!);
      } else {
        emit(DoLoginError("Invalid response format"));
      }
    } catch (e) {
      emit(DoLoginError(e.toString()));
    }
  }
}
