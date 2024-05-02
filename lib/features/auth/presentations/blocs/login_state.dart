enum LoginStatus { login, signup, forgotPassword }

class LoginState {
  final String? email;
  final String? password;
  final LoginStatus loginStatus;
  final String? username;
  final bool passwordVisible;

  LoginState({
    this.email,
    this.password,
    required this.loginStatus,
    this.username,
    this.passwordVisible = false,
  });
  factory LoginState.initial() {
    return LoginState(loginStatus: LoginStatus.login);
  }
  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? loginStatus,
    String? username,
    bool? passwordVisible,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      loginStatus: loginStatus ?? this.loginStatus,
      username: username ?? this.username,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
