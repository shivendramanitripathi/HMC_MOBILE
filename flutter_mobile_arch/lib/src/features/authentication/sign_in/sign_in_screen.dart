
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/authentication/sign_in/provider/sign_in_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../app_configs/app_colors.dart';
import '../../../common_widgets/buttons/primary_button.dart';
import '../../../common_widgets/custom_fields/text/custom_text_field.dart';
import '../../../common_widgets/custom_loading_indicator.dart';
import '../../../common_widgets/responsive_center.dart';
import '../../../constants/app_sizes.dart';
import '../../../constants/breakpoints.dart';
import '../../../routing/app_route_ext.dart';
import '../../../utils/validator.dart';
import '../../dashboard/dashboard.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final LocalAuthentication localAuthentication = LocalAuthentication();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final String _storageKey = 'isAuthenticated';
  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  Future<void> checkAuth() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    log('Biometric available: $isAvailable');

    if (isAvailable) {
      bool result = await localAuthentication.authenticate(
        localizedReason: "Scan your fingerprint to authenticate",
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (result) {
        await storeAuthenticationStatus();
        GoRouter.of(context).go('/dashboard');
      } else {
        log("Authentication failed or permission denied");
      }
    } else {
      log("No biometrics available");
    }
  }

  Future<void> storeAuthenticationStatus() async {
    await secureStorage.write(key: _storageKey, value: 'true');
    log("User authentication status stored as 'true'");
  }

  Future<void> checkStoredAuthenticationStatus() async {
    String? isAuthenticated = await secureStorage.read(key: _storageKey);

    if (isAuthenticated == 'true') {
      log("User is already authenticated: $isAuthenticated");
      GoRouter.of(context).go('/dashboard');
    } else {
      log("User is not authenticated yet or no data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    final signInProvider = context.read<SignInProvider>();
    final GlobalKey<CustomTextFieldState> emailFieldKey =
        GlobalKey<CustomTextFieldState>();
    final GlobalKey<CustomTextFieldState> passwordFieldKey =
        GlobalKey<CustomTextFieldState>();

    return ChangeNotifierProvider.value(
      value: signInProvider,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: ResponsiveCenter(
                maxContentWidth: Breakpoint.desktop,
                padding: const EdgeInsets.all(Sizes.p16),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: Sizes.p64),
                            Text(
                              AppLocalizations.of(context)!.welcome,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: Sizes.p64),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Sing In",
                                // 'Sign in'.hardcoded,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            const SizedBox(height: Sizes.p16),
                            Form(
                              key: signInProvider.loginFormKey,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    labelText: "Email ID/Phone Number",
                                    //'E-mail id/phone number'.hardcoded,
                                    fieldKey: emailFieldKey,
                                    onSaved: (value) =>
                                        signInProvider.email = value,

                                    validator:
                                        Validator.validateEmailOrPhoneNumber,
                                    textInputAction: TextInputAction.next,

                                    initialValue: signInProvider.rememberMe
                                        ? signInProvider.email
                                        : '',
                                  ),
                                  const SizedBox(height: Sizes.p16),
                                  CustomTextField(
                                    labelText: "Password",
                                    fieldKey: passwordFieldKey,
                                    onSaved: (value) =>
                                        signInProvider.password = value,
                                    validator: Validator.validatePassword,
                                    isPassword: true,
                                    textInputAction: TextInputAction.done,
                                    initialValue: signInProvider.rememberMe
                                        ? signInProvider.password
                                        : '',
                                  ),
                                  const SizedBox(height: Sizes.p16),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () {
                                        // context.pushNamed(
                                        //     AppRoute.forgotPassword.getName);
                                      },
                                      child: const Text(
                                        "Forgot Password",
                                        // 'Forgot Password?'.hardcoded,
                                        style: TextStyle(
                                          color: AppColors.primaryTextColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: Sizes.p32),
                                  PrimaryButton(
                                    text: "Log In",
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const DashboardScreen()),
                                      );
                                      context
                                          .goNamed(AppRoute.dashboard.getName);
                                    },
                                  ),
                                  const SizedBox(height: Sizes.p16),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          activeColor: Colors.black,
                                          value: signInProvider.rememberMe,
                                          onChanged:
                                              signInProvider.toggleRememberMe,
                                        ),
                                        const Text(
                                          "Remember me",
                                          //'Remember me'.hardcoded,
                                          style: TextStyle(
                                            color: AppColors.primaryTextColor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: Sizes.p16),
                          child: Column(
                            children: [
                              const Text("or"),
                              const SizedBox(height: Sizes.p8),
                              TextButton(
                                onPressed: () {
                                  context.goNamed(
                                      AppRoute.signUpSelection.getName);
                                },
                                child: const Text(
                                  "Sign Up",
                                  // 'Sign up'.hardcoded,
                                  style: TextStyle(
                                    color: AppColors.primaryTextColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (context.watch<SignInProvider>().isLoading)
              const CustomLoadingIndicator()
          ],
        ),
      ),
    );
  }
}
