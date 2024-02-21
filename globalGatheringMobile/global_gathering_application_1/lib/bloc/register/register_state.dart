part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class DoRegisterLoading extends RegisterState {}

class DoRegisterSuccess extends RegisterState {
  final RegisterReponse userRegister;
  DoRegisterSuccess(this.userRegister);
}

class DoRegisterError extends RegisterState {
  final String error;
  DoRegisterError(this.error);
}
