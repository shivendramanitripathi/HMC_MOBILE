import 'package:flutter/material.dart';

import '../../../../app_configs/app_colors.dart';
import '../../../../app_configs/app_images.dart';
import '../../../../constants/app_sizes.dart';


class RecaptchaWidget extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const RecaptchaWidget({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Sizes.p8),
      decoration: BoxDecoration(
        color: AppColors.greyBackgroundColor,
        borderRadius: BorderRadius.circular(Sizes.p4),
        border: Border.all(color: AppColors.outlineBorderColor, width: 1.0),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
          ),
          const Expanded(
            child: Text(
                "I am not a robot",
                //'I am not a robot'.hardcoded
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: Sizes.p16),
            child: Image.asset(
              I.captchaIcon,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
