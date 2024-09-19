import 'package:flutter/material.dart';

import '../../app_configs/app_images.dart';
import '../../constants/app_sizes.dart';

class CustomDrawerButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomDrawerButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(Sizes.p12),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey.shade400,
        elevation: 8,
      ),
      child: Image.asset(
        AppImages.menuIcon,
        width: 24,
        height: 24,
      ),
    );
  }
}
