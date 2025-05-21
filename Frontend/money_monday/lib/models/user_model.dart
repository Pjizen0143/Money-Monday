class User {
  final String username;
  final String email;
  final String password;

  User({required this.username, required this.email, required this.password});

  // แปลง User เป็น JSON ก่อนส่งไปยัง API
  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, 'password': password};
  }
}

class UserPublic {
  final int id;
  final String username;
  final String email;

  UserPublic({required this.id, required this.username, required this.email});

  factory UserPublic.fromJson(Map<String, dynamic> json) {
    return UserPublic(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}
