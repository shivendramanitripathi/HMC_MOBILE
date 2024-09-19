import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/app_configs/app_colors.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../app_configs/app_logger.dart';
import '../../../common_widgets/buttons/primary_button.dart';
import '../../../services/service_locator.dart';

class SendOTPScreen extends StatelessWidget {
  final AppLogger logger = getIt<AppLogger>();
  SendOTPScreen({super.key});

  final TextEditingController mobileNumber = TextEditingController();

  Future<void> submit(BuildContext context) async {
    if (mobileNumber.text.isEmpty) return;

    String? appSignatureID;
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        appSignatureID = await SmsAutoFill().getAppSignature;
      } catch (e) {
        logger.logError('Failed to get app signature', error: e);
        appSignatureID = null;
      }
    }

    final Map<String, String> sendOtpData = {
      "mobile_number": mobileNumber.text,
      "app_signature_id": appSignatureID ?? '',
    };
    logger.logInfo(sendOtpData.toString());
    GoRouter.of(context).go('/verifyByOtp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/login');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.color2),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: mobileNumber,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Mobile Number",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            PrimaryButton(onPressed: () => submit(context), text: 'Submit'),
          ],
        ),
      ),
    );
  }
}
