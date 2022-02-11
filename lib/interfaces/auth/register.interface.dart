class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterRequest(
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
  );

  Map<String, String> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }
}