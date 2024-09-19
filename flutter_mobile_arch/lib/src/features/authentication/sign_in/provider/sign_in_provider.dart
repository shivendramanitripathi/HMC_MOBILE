import 'package:flutter/material.dart';

class SignInProvider with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool rememberMe = false;
  bool isLoading = false;

  VoidCallback? onTokenRefreshFailure;
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }
}
