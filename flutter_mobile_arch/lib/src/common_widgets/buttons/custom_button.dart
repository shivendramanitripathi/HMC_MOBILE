import 'package:flutter/material.dart';

import '../../app_configs/test_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String assetName;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool fullWidth;
  const CustomButton({
    required this.text,
    required this.assetName,
    required this.onPressed,
    required this.backgroundColor,
    this.fullWidth = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        icon: Image.asset(assetName, height: 24, width: 24),
        label: Text(
          text,
          style: xTextStyle16()
        ),
      ),
    );
  }
}
