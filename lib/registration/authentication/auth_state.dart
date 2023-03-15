
abstract class AuthState{}

class AuthInitial extends AuthState{}
class Authenticating extends AuthState{}
class Authenticated extends AuthState{}
class AuthenticationField extends AuthState{
  String message;

  AuthenticationField(this.message);
}
class LoggedOut extends AuthState{}