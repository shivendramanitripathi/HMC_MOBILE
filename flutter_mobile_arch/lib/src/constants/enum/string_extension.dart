import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum StringOperation {
  validation,
  formatting,
  localization,
  manipulation,
  conversion,
  urlValidation,
}

extension StringExtensions on String {
  String performOperation(StringOperation operation,
      {BuildContext? context, String format = 'yyyy-MM-dd'}) {
    switch (operation) {
      case StringOperation.validation:
        return isValidEmail ? 'Valid Email' : 'Invalid Email';
      case StringOperation.formatting:
        return capitalizeEachWord;
      case StringOperation.localization:
        return context != null ? tr(context) : this;
      case StringOperation.manipulation:
        return removeWhitespace;
      case StringOperation.conversion:
        return toDateTime(format: format)?.toString() ?? 'Invalid Date';
      case StringOperation.urlValidation:
        return isValidUrl ? 'Valid URL' : 'Invalid URL';
      default:
        return this;
    }
  }

  bool get isValidEmail {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(this);
  }

  String get capitalizeEachWord {
    return split(' ')
        .map((word) => word.isEmpty
            ? ''
            : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  String tr(BuildContext context) {
    final Map<String, String> translations = {
      'hello': 'Hola',
      'world': 'Mundo',
    };
    return translations[this] ?? this;
  }

  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }

  DateTime? toDateTime({String format = 'yyyy-MM-dd'}) {
    try {
      return DateFormat(format).parse(this);
    } catch (e) {
      return null;
    }
  }

  bool get isValidUrl {
    final regex = RegExp(
      r'^(http|https):\/\/[^\s$.?#].[^\s]*$',
      caseSensitive: false,
    );
    return regex.hasMatch(this);
  }
}
