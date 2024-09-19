import 'package:flutter/cupertino.dart';
import 'package:flutter_mobile_arch/src/routing/scaffold_with_nav_bar.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/otp/sent_otp_screen.dart';
import '../features/authentication/otp/verify_otp.dart';
import '../features/authentication/sign_in/sign_in_screen.dart';
import '../features/authentication/sign_up/sign_up_screen.dart';
import '../features/authentication/sign_up/sign_up_selection_screen.dart';
import '../features/barcode/barcode_screen.dart';
import '../features/dashboard/dashboard.dart';
import '../features/form/form_data_list.dart';
import '../features/form/form_screen.dart';
import '../features/splash/splash_screen.dart';
import 'app_route_ext.dart';
import 'not_found_screen.dart';

class AppRouter {
  late final GoRouter goRouter;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  AppRouter() {
    goRouter = GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: AppRoute.splash.getPath,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoute.splash.getPath,
          name: AppRoute.splash.getName,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: AppRoute.login.getPath,
          name: AppRoute.login.getName,
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: AppRoute.signUpSelection.getPath,
          name: AppRoute.signUpSelection.getName,
          builder: (context, state) => const SignUpSelectionScreen(),
        ),
        GoRoute(
          path: AppRoute.signUp.getPath,
          name: AppRoute.signUp.getName,
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: AppRoute.otp.getPath,
          name: AppRoute.otp.getName,
          builder: (context, state) => SendOTPScreen(),
        ),
        GoRoute(
          path: AppRoute.verifyByOtp.getPath,
          name: AppRoute.verifyByOtp.getName,
          builder: (context, state) => const VerifyOTPScreen(),
        ),
        StatefulShellRoute.indexedStack(
          builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
            return ScaffoldWithNavBar(navigationShell: navigationShell);
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoute.dashboard.getPath,
                  name: AppRoute.dashboard.getName,
                  builder: (context, state) => const DashboardScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoute.barcode.getPath,
                  name: AppRoute.barcode.getName,
                  builder: (context, state) => const BarcodeScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoute.formScreen.getPath,
                  name: AppRoute.formScreen.getName,
                  builder: (context, state) => const FormScreen(),
                  routes: [
                    GoRoute(
                      path: AppRoute.formList.getPath, // sub-route path without leading '/'
                      name: AppRoute.formList.getName,
                      builder: (context, state) => const FromListScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => const NotFoundScreen(),
    );
  }
}
