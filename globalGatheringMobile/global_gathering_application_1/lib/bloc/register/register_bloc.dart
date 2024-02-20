import 'package:bloc/bloc.dart';
import 'package:global_gathering_application_1/model/dto/register_dto.dart';
import 'package:global_gathering_application_1/repository/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterLoading();

      try {
        final RegisterDto registerDto = RegisterDto(
          username: event.registerDto.username,
          fullName: event.registerDto.fullName,
          password: event.registerDto.password,
          verifyPassword: event.registerDto.password,
          email: event.registerDto.email,
        );

        await authRepository.register(registerDto);
        yield RegisterSuccess();
      } catch (error) {
        yield RegisterFailure('Failed to register');
      }
    }
  }
}
