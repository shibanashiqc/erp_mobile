part of 'login_cubit.dart';

abstract class LoginState {
  const LoginState();
}

class InitialLoginState extends LoginState {}

class LoadedLoginState extends LoginState {
  const LoadedLoginState();
}

class LoadingLoginState extends LoginState {
  const LoadingLoginState();
}

class ErrorLoginState extends LoginState {
  final String message;
  const ErrorLoginState({required this.message});
}
  
class ChangeFormValuesState extends LoginState {
  String type;
  dynamic value;
  ChangeFormValuesState(
      {required this.type, required this.value});
}


