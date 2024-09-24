import 'dart:developer';
import 'dart:io';
import 'package:catcher/core/catcher.dart';
import 'package:catcher/handlers/console_handler.dart';
import 'package:catcher/handlers/email_manual_handler.dart';
import 'package:catcher/mode/dialog_report_mode.dart';
import 'package:catcher/mode/silent_report_mode.dart';
import 'package:catcher/model/catcher_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_arch/src/app_configs/app_logger.dart';
import 'package:flutter_mobile_arch/src/app_configs/string/localizationprovider.dart';
import 'package:flutter_mobile_arch/src/common_widgets/provider/root_device.dart';
import 'package:flutter_mobile_arch/src/features/dashboard/provider/dashboard_provider.dart';
import 'package:flutter_mobile_arch/src/features/form/provider/visitor_provider.dart';
import 'package:flutter_mobile_arch/src/features/in_app_purchase/provider/in_app_purchase_controller.dart';
import 'package:flutter_mobile_arch/src/models/vistor_model.dart';
import 'package:flutter_mobile_arch/src/common_widgets/provider/theme_provider.dart';
import 'package:flutter_mobile_arch/src/features/authentication/sign_in/provider/sign_in_provider.dart';
import 'package:flutter_mobile_arch/src/features/authentication/sign_up/provider/sign_up_provider.dart';
import 'package:flutter_mobile_arch/src/features/splash/provider/splash_screen_provider.dart';
import 'package:flutter_mobile_arch/src/routing/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobile_arch/src/services/api_service.dart';
import 'package:flutter_mobile_arch/src/services/service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_10y.dart';
import 'package:upgrader/upgrader.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeTimeZones();
  AndroidInitializationSettings androidInitializationSettings =
      const AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings iosSetting = const DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestCriticalPermission: true,
    requestSoundPermission: true,
  );
  InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings, iOS: iosSetting);
  bool? initialized =
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  log("Notification initialized: $initialized");
  setupServiceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(VisitorAdapter());
  await Hive.openBox<Visitor>('visitors');
  CatcherOptions debugOptions = CatcherOptions(
    DialogReportMode(),
    [ConsoleHandler()],
  );
  CatcherOptions releaseOptions = CatcherOptions(
    SilentReportMode(),
    [
      ConsoleHandler(),
      EmailManualHandler(['shivendramanitripathi549@gmail.com'])
    ],
  );
  Catcher(
    rootWidget: UpgradeAlert(
        dialogStyle: Platform.isAndroid
            ? UpgradeDialogStyle.material
            : UpgradeDialogStyle.cupertino,
        child: const MyApp()),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {}
  }

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<AppRouter>().goRouter;
    return MultiProvider(
      providers: [
        Provider<ApiService>(create: (_) => GetIt.I<ApiService>()),
        Provider<AppLogger>(create: (_) => GetIt.I<AppLogger>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<SignInProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<SignUpProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<SplashProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<VisitorProvider>()),
        ChangeNotifierProvider(
            create: (_) => GetIt.I<DashboardSupportProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<ThemeProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<LocalizationProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<RootCheckerProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<InAppPurchaseProvider>()),
      ],
      child: Consumer2<ThemeProvider, LocalizationProvider>(
        builder: (context, themeProvider, localizationProvider, child) {
          return MaterialApp.router(
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('hi', ''),
            ],
            locale: localizationProvider.locale,
            onGenerateTitle: (BuildContext context) =>
                AppLocalizations.of(context)!.appName,
            theme: themeProvider.currentTheme,
          );
        },
      ),
    );
  }
}
