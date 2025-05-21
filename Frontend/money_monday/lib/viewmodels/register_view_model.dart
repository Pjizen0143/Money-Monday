import 'package:flutter/material.dart';
import 'package:money_monday/models/user_model.dart';
import 'package:money_monday/services/auth_service/register_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterService _registerService = RegisterService();

  bool isLoading = false;
  UserPublic? userResponse;
  String? errorMessage;

  Future<void> register(User user) async {
    isLoading = true;
    userResponse = null;
    errorMessage = null;
    notifyListeners();

    try {
      userResponse = await _registerService.register(user);
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
