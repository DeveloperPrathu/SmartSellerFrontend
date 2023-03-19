abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginSubmitting extends LoginState {}

class LoginSuccess extends LoginState {
  String token;

  LoginSuccess(this.token);
}

class LoginFailed extends LoginState {
  String message;

  LoginFailed(this.message);
}