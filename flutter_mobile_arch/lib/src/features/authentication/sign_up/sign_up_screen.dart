import 'package:flutter_mobile_arch/src/features/authentication/sign_up/provider/sign_up_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../../app_configs/app_colors.dart';
import '../../../app_configs/app_images.dart';
import '../../../common_widgets/buttons/primary_button.dart';
import '../../../common_widgets/custom_fields/phone/custom_phone_number_field.dart';
import '../../../common_widgets/custom_fields/text/custom_text_field.dart';
import '../../../common_widgets/custom_loading_indicator.dart';
import '../../../common_widgets/responsive_center.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/breakpoints.dart';
import '../../../routing/app_route_ext.dart';
import '../../../utils/validator.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const _SignUpForm();
  }
}

class _SignUpForm extends StatelessWidget {
  const _SignUpForm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ResponsiveCenter(
        maxContentWidth: Breakpoint.desktop,
        padding: const EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Consumer<SignUpProvider>(
                      builder: (context, signUpProvider, _) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: Sizes.p64),
                          Image.asset(
                            AppImages.logo,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.width * 0.3,
                          ),
                          const SizedBox(height: Sizes.p24),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Sign Up",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                          const SizedBox(height: Sizes.p16),
                          Form(
                            key: signUpProvider.signUpFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (signUpProvider.usePhoneNumber)
                                  CustomPhoneNumberField(
                                    countries: signUpProvider.countries,
                                    onSaved: (value) {
                                      if (value != null) {
                                        final parts = value.split('-');
                                        if (parts.length == 2) {
                                          signUpProvider.countryCode = parts[0];
                                          signUpProvider.phoneNumber = parts[1];
                                        }
                                      }
                                    },
                                    onChanged: (value) =>
                                        signUpProvider.validateForm(),
                                  )
                                else
                                  CustomTextField(
                                    labelText: "Enter your Email",
                                    //'Enter your e-mail id'.hardcoded,
                                    onSaved: (value) =>
                                        signUpProvider.email = value,
                                    validator: Validator.validateEmail,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) =>
                                        signUpProvider.validateForm(),
                                  ),
                                const SizedBox(height: Sizes.p16),
                                CustomTextField(
                                  labelText: "Password",
                                  //'Password'.hardcoded,
                                  onSaved: (value) =>
                                      signUpProvider.password = value,
                                  validator: Validator.validatePassword,
                                  isPassword: true,
                                  onChanged: (value) {
                                    signUpProvider.password = value;
                                    signUpProvider.validateForm();
                                  },
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: Sizes.p16),
                                CustomTextField(
                                  labelText: "Password",
                                  onSaved: (value) =>
                                      signUpProvider.confirmPassword = value,
                                  validator: (value) =>
                                      Validator.validateConfirmPassword(
                                          value, signUpProvider.password),
                                  isPassword: true,
                                  onChanged: (value) {
                                    signUpProvider.confirmPassword = value;
                                    signUpProvider.validateForm();
                                  },
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(height: Sizes.p32),
                                const Text(
                                  'Please read and accept the Terms & Conditions',
                                  style: TextStyle(
                                      color: AppColors.primaryTextColor,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: signUpProvider.agreeToTerms,
                                      activeColor: Colors.black,
                                      onChanged: (value) {
                                        signUpProvider
                                            .toggleAgreeToTerms(value);
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: Sizes.p16),
                                Center(
                                  child: PrimaryButton(
                                    text: "new label",
                                    //'CONTINUE'.hardcoded,
                                    fullWidth: false,
                                    onPressed: () {},
                                  ),
                                ),
                                const SizedBox(height: Sizes.p64),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: Sizes.p16),
                  child: TextButton(
                    onPressed: () {
                      context.goNamed(AppRoute.login.getName);
                    },
                    child: const Text(
                      'Already have an account?',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (context.watch<SignUpProvider>().isLoading)
              const Center(
                child: CustomLoadingIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
