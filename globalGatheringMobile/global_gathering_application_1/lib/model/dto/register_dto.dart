class RegisterDto {
  final String username;
  final String fullName;
  final String password;
  final String verifyPassword;
  final String email;

  RegisterDto({
    required this.username,
    required this.fullName,
    required this.password,
    required this.verifyPassword,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullName': fullName,
      'password': password,
      'verifyPassword': verifyPassword,
      'email': email,
    };
  }
}
