import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app_configs/app_images.dart';
import '../../../constants/app_sizes.dart';

class AutoDismissDialog extends StatelessWidget {
  final String message;
  final String imageAsset;
  final int duration;
  final VoidCallback onDismiss;

  const AutoDismissDialog({
    super.key,
    required this.message,
    this.imageAsset = AppImages.verify,
    required this.onDismiss,
    this.duration = 3, // Default to 3 seconds
  });

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: duration), () {
      if (context.mounted) {
        context.pop();
        onDismiss();
      }
    });

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.p32),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.3,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAsset,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.3,
            ),
            const SizedBox(height: Sizes.p8),
            Padding(
              padding: const EdgeInsets.all(Sizes.p8),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
