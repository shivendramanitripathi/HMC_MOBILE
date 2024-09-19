import 'package:flutter/material.dart';

class Strings {
  static const defaultLocale = Locale('en', 'US');

  static Map<String, Map<String, String>> localizedValues = {
    'en_US': {
      'appName': 'Mobile App',
      'loginOrSignUpHeader': 'Login or Sign Up',
      'loginOrSignUpBody': 'Please login or sign up to continue.',
      'phoneNumber': 'Phone Number',
      'email': 'Email',
    },
  };

  String getString(String key, Locale locale) {
    String localeKey = locale.toString();
    return localizedValues[localeKey]?[key] ?? key;
  }
}
