abstract class AuthEvent {
  const AuthEvent();
}

class AuthCheckRequestedEvent extends AuthEvent {
  const AuthCheckRequestedEvent();
}

class AuthLoginRequestedEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequestedEvent({
    required this.email,
    required this.password,
  });
}

class AuthSignUpRequestedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUpRequestedEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthLogoutRequestedEvent extends AuthEvent {
  const AuthLogoutRequestedEvent();
}
