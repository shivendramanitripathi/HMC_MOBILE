import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/routing/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'app_configs/app_logger.dart';
import 'features/authentication/sign_in/provider/sign_in_provider.dart';
import 'features/authentication/sign_up/provider/sign_up_provider.dart';
import 'features/splash/provider/splash_screen_provider.dart';
import 'package:app_links/app_links.dart';
class MyApp extends StatefulWidget {
   const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  late StreamSubscription<Uri> _linkSubscription;

  @override
  void initState() {
    super.initState();
    _appLinks = AppLinks();
    _setupDeepLinkListener();
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

  void _setupDeepLinkListener() {
    final logger = GetIt.I<AppLogger>();
    _linkSubscription = _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        logger.logInfo('Received deep link: $uri');
        _handleDeepLink(uri);
      }
    });
  }

  void _handleDeepLink(Uri uri) {
    final route = uri.path;
    if (route.isNotEmpty) {
      GoRouter.of(context).go('/login');

    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GetIt.I<AppRouter>().goRouter;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GetIt.I<SplashProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<SignInProvider>()),
        ChangeNotifierProvider(create: (_) => GetIt.I<SignUpProvider>()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        restorationScopeId: 'app',
        onGenerateTitle: (BuildContext context) => 'Hybrid Mobile Arch',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.grey,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( const MyApp());
}
