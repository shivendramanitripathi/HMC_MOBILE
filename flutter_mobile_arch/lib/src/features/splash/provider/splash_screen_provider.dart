import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashProvider with ChangeNotifier {
  Future<void> startNavigation(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    GoRouter.of(context).go('/login');
  }
}
