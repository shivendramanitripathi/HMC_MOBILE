import 'package:flutter/material.dart';

import 'auto_dismiss/auto_dismiss_dialog.dart';

void showAutoDismissDialog({required BuildContext context, required String message, required VoidCallback onDismiss}) {
  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.9), // Adjust the opacity as needed
    transitionDuration: const Duration(milliseconds: 200),
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return SafeArea(
        child: Stack(
          children: [
            Center(
              child: AutoDismissDialog(
                message: message,
                onDismiss: onDismiss,
              ),
            ),
          ],
        ),
      );
    },
  );
}
