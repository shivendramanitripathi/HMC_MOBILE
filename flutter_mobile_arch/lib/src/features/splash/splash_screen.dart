import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobile_arch/src/features/splash/provider/splash_screen_provider.dart';
import '../../common_widgets/responsive_center.dart';
import '../../constants/app_sizes.dart';
import '../../constants/breakpoints.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashProvider>().startNavigation(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return const ResponsiveCenter(
            maxContentWidth: Breakpoint.desktop,
            padding: EdgeInsets.all(Sizes.p16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Splash Screen",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
