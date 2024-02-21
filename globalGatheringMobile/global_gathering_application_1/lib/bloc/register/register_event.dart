part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterDto registerDto;
  DoRegisterEvent({required this.registerDto});
}
