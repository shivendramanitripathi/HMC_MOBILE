import 'package:flutter_mobile_arch/src/app_configs/app_logger.dart';
import 'package:flutter_mobile_arch/src/common_widgets/provider/root_device.dart';
import 'package:flutter_mobile_arch/src/features/in_app_purchase/in_app_purchase_view.dart';
import 'package:flutter_mobile_arch/src/features/in_app_purchase/provider/in_app_purchase_controller.dart';
import 'package:get_it/get_it.dart';
import '../app_configs/string/localizationprovider.dart';
import '../common_widgets/provider/theme_provider.dart';
import '../features/authentication/sign_in/provider/sign_in_provider.dart';
import '../features/authentication/sign_up/provider/sign_up_provider.dart';
import '../features/dashboard/provider/dashboard_provider.dart';
import '../features/form/provider/visitor_provider.dart';
import '../features/splash/provider/splash_screen_provider.dart';
import '../routing/app_router.dart';
import 'api_service.dart';
import 'http_interceptor.dart';
import 'token_service.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register the HttpInterceptor
  getIt.registerSingleton<HttpInterceptor>(HttpInterceptor());
  getIt.registerSingleton<ApiService>(ApiService.instance);
  getIt<ApiService>().setInterceptor(getIt<HttpInterceptor>());
  getIt.registerSingleton<TokenService>(TokenService());
  getIt.registerSingleton<AppLogger>(AppLogger());
  getIt.registerLazySingleton<SplashProvider>(() => SplashProvider());
  getIt.registerLazySingleton<VisitorProvider>(() => VisitorProvider());
  getIt.registerLazySingleton<SignInProvider>(() => SignInProvider());
  getIt.registerLazySingleton<SignUpProvider>(() => SignUpProvider());
  getIt.registerLazySingleton<InAppPurchaseProvider>(
      () => InAppPurchaseProvider());
  getIt.registerLazySingleton<RootCheckerProvider>(() => RootCheckerProvider());
  getIt.registerLazySingleton<DashboardSupportProvider>(
      () => DashboardSupportProvider());
  getIt.registerLazySingleton<LocalizationProvider>(
      () => LocalizationProvider());
  getIt.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
  getIt.registerSingleton<AppRouter>(AppRouter());
}
