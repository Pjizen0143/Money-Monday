import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/login_response.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool isLoading = false;
  LoginResponse? loginResponse;
  String? errorMessage;

  Future<void> login(String username, String password) async {
    isLoading = true;
    loginResponse = null;
    errorMessage = null;
    notifyListeners();

    try {
      loginResponse = await _authService.login(username, password);
    } catch (e) {
      errorMessage = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
