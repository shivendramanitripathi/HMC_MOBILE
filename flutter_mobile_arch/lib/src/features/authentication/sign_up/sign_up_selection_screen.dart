import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app_configs/app_colors.dart';
import '../../../app_configs/app_images.dart';
import '../../../common_widgets/buttons/secendory_button.dart';
import '../../../constants/app_sizes.dart';
import '../../../routing/app_route_ext.dart';

class SignUpSelectionScreen extends StatelessWidget {
  const SignUpSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: Sizes.p64),
                  Image.asset(
                    AppImages.logo,
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.width * 0.3,
                  ),
                  const SizedBox(height: Sizes.p32),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Sign Up",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: Sizes.p32),
                  SecondaryButton(
                    text: "Phone Number",
                    onPressed: () {
                      context.goNamed(AppRoute.otp.getName);
                    },
                    imageAsset: AppImages.phoneIcon,
                    isOutlined: false,
                  ),
                  const SizedBox(height: Sizes.p16),
                  const Text("or"),
                  const SizedBox(height: Sizes.p16),
                  SecondaryButton(
                    text: "Email",
                    onPressed: () {
                    },
                    imageAsset: AppImages.mailIcon,
                    isOutlined: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: Sizes.p16),
              child: TextButton(
                onPressed: () {
                  context.goNamed(AppRoute.login.getName);
                },
                child: const Text(
                  "already_have_an_account",
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
