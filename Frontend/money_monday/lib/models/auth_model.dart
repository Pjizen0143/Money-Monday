class LoginResponse {
  final String username;
  final String email;

  LoginResponse({required this.username, required this.email});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(username: json['username'], email: json['email']);
  }
}
