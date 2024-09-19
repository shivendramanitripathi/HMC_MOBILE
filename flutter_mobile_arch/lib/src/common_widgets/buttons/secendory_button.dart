import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String? imageAsset;
  final bool fullWidth;
  final bool isOutlined;

  const SecondaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.imageAsset,
    this.fullWidth = true,
    this.isOutlined = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (imageAsset != null)
          Padding(
            padding: const EdgeInsets.only(left: Sizes.p24),
            child: Image.asset(imageAsset!, width: 24, height: 24),
          ),
        if (imageAsset != null) const SizedBox(width: Sizes.p8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: Sizes.p24),
            child: Text(
              text,
              style: isOutlined ? const TextStyle(color: Colors.black) : const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        if (imageAsset != null) const SizedBox(width: Sizes.p24), // To balance the padding on the right
      ],
    );

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: isOutlined
          ? OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.p12),
                ),
              ),
              onPressed: onPressed,
              child: buttonContent,
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Sizes.p12),
                ),
              ),
              onPressed: onPressed,
              child: buttonContent,
            ),
    );
  }
}
