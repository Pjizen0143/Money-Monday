import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:money_monday/constants/api_constants.dart';
import 'package:money_monday/models/user_model.dart';
import 'package:money_monday/views/utils/app_exception.dart';

class RegisterService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<UserPublic> register(User user) async {
    final url = Uri.parse('$baseUrl/users/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      return UserPublic.fromJson(responseJson);
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final errorMessage =
          data['detail'] ?? 'Unknow error please tye again later';
      throw AppException('Register failed: $errorMessage');
    }
  }
}
