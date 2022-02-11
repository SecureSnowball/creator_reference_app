class LoginRequest {
  final String email;
  final String password;

  const LoginRequest(this.email, this.password);

  Map<String, String> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}