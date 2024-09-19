import 'package:flutter/material.dart';

import '../../app_configs/app_images.dart';
import '../../constants/app_sizes.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Icon? imageIcon;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = true,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.borderColor,
    this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return Row(
      children: [
        if (!fullWidth) const Spacer(),
        Expanded(
          flex: fullWidth ? 1 : 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Sizes.p8),
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 2.0, // Adjust the width as needed
                ),
              ),
            ),
            onPressed: onPressed,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                  ),
                ),
                imageIcon ??
                    Image.asset(
                      AppImages.arrowForward,
                      width: 24,
                      height: 24,
                    ),
                const SizedBox(width: Sizes.p16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
