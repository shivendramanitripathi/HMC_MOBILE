import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:root_checker_plus/root_checker_plus.dart';

class RootCheckerProvider extends ChangeNotifier {
  bool _rootedCheck = false;
  bool _jailbreak = false;
  bool _devMode = false;

  bool get rootedCheck => _rootedCheck;
  bool get jailbreak => _jailbreak;
  bool get devMode => _devMode;

  RootCheckerProvider() {
    _checkRootStatus();
  }

  Future<void> _checkRootStatus() async {
    try {
      if (Platform.isAndroid) {
        _rootedCheck = (await RootCheckerPlus.isRootChecker()) ?? false;
        _devMode = (await RootCheckerPlus.isDeveloperMode()) ?? false;
      }

      if (Platform.isIOS) {
        _jailbreak = (await RootCheckerPlus.isJailbreak()) ?? false;
      }
    } on PlatformException {
      _rootedCheck = false;
      _devMode = false;
      _jailbreak = false;
    }
    if (_rootedCheck || _devMode) {
      // _showStatusDialog();
    }

    notifyListeners();
  }

  // void _showStatusDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Device Status'),
  //         content: Text(
  //           _rootedCheck
  //               ? 'Your device is rooted.'
  //               : _devMode
  //               ? 'Developer mode is enabled.'
  //               : 'Unknown status.',
  //         ),
  //         actions: [
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
