import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';

class AuthService {
  final String baseUrl =
      'http://localhost:8000'; // เปลี่ยนเป็นของจริงเมื่อ deploy

  Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
