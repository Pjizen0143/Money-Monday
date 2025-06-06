import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_monday/constants/api_constants.dart';
import 'package:money_monday/views/utils/app_exception.dart';
import '../../models/auth_model.dart';

class AuthService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<LoginResponse> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final errorMessage =
          data['detail'] ?? 'Unknow error please tye again later';
      throw AppException('Register failed: $errorMessage');
    }
  }
}
