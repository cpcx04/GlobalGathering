part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final RegisterDto registerDto;

  RegisterButtonPressed({required this.registerDto});
}
