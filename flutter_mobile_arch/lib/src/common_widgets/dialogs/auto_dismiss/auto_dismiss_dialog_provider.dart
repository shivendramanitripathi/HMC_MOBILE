import 'dart:async';
import 'package:flutter/material.dart';

class AutoDismissDialogProvider with ChangeNotifier {
  AutoDismissDialogProvider({required int duration}) {
    _startTimer(duration);
  }

  void _startTimer(int duration) {
    Timer(Duration(seconds: duration), () {
      notifyListeners();
    });
  }
}
