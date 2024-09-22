import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
class SignInProvider with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool rememberMe = false;
  bool isLoading = false;
  final LocalAuthentication localAuth = LocalAuthentication();

  Future<void> storeBiometricToken(String token) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 201) {
      // Successfully stored token
      print('Token stored successfully: ${response.body}');
    } else {
      // Handle error
      print('Failed to store token: ${response.statusCode}');
    }
  }

  // Simulated method to authenticate on a new device
  Future<bool> authenticateWithBiometrics() async {
    bool isAvailable = await localAuth.canCheckBiometrics;

    if (isAvailable) {
      bool authenticated = await localAuth.authenticate(
        localizedReason: "Authenticate using biometrics",
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated) {
        final response = await http.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts/1'), // Simulate verification
        );

        if (response.statusCode == 200) {
          // Simulate a successful verification
          print('Token verified successfully: ${response.body}');
          return true;
        } else {
          // Authentication failed
          print('Failed to verify token: ${response.statusCode}');
          return false;
        }
      }
    }
    return false;
  }
  VoidCallback? onTokenRefreshFailure;
  void toggleRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }
}
