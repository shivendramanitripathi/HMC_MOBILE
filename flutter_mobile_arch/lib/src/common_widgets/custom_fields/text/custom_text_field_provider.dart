import 'package:flutter/material.dart';

class CustomTextFieldProvider with ChangeNotifier {
  CustomTextFieldProvider({
    this.onValueChanged,
    this.initialValue,
  }) {
    textFieldController = initialValue;
  }

  final Function(String)? onValueChanged;
  final String? initialValue;

  final TextEditingController _controller = TextEditingController();
  TextEditingController get txtFieldController => _controller;

  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  set textFieldController(String? value) {
    _controller.text = value ?? '';
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onChanged(String value) {
    onValueChanged?.call(value);
  }
}
