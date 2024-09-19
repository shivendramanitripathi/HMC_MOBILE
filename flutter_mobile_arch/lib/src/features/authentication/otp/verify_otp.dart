import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';
import '../../../common_widgets/buttons/primary_button.dart';
import '../../../app_configs/app_logger.dart';  // Import AppLogger
import '../../../services/service_locator.dart';  // Import service locator to access AppLogger

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key});

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> with CodeAutoFill {
  final AppLogger logger = getIt<AppLogger>();  // Get an instance of AppLogger
  String codeValue = "";

  @override
  void codeUpdated() {
    logger.logInfo("Update code $code");
    setState(() {
      logger.logInfo("codeUpdated");
    });
  }

  @override
  void initState() {
    super.initState();
    listenOtp();
  }

  Future<bool> verifyOtp(String otp) async {
    await Future.delayed(const Duration(seconds: 2));
    return otp == "";
  }

  void _onVerifyPressed() async {
    bool isVerified = await verifyOtp(codeValue);
    if (isVerified) {
      logger.logInfo("OTP verified successfully");
      GoRouter.of(context).go('/dashboard');
    } else {
      logger.logWarning("OTP verification failed");
    }
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    SmsAutoFill().listenForCode;
    logger.logInfo("OTP listen Called");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    logger.logInfo("unregisterListener called");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go('/otp');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: PinFieldAutoFill(
                currentCode: codeValue,
                codeLength: 4,
                onCodeChanged: (code) {
                  logger.logInfo("onCodeChanged $code");
                  setState(() {
                    codeValue = code.toString();
                  });
                },
                onCodeSubmitted: (val) {
                  logger.logInfo("onCodeSubmitted $val");
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(onPressed: _onVerifyPressed, text: 'Verify OTP'),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(onPressed: listenOtp, text: 'Resend'),
          ],
        ),
      ),
    );
  }
}
