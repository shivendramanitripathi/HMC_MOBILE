import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../app_configs/app_colors.dart';
import '../../app_configs/app_images.dart';
import '../../constants/app_sizes.dart';
import '../../features/dashboard/provider/dashboard_provider.dart';
import '../../routing/app_route_ext.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.color1, AppColors.color2],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _DrawerHeader(),
            _buildDrawerItem(
              context,
              assetPath: I.homeIcon,
              text: "Home",
              onTap: () {
                GoRouter.of(context).go('/dashboard');
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              assetPath: I.alertsIcon,
              text: "Work ",
              onTap: () {
                // GoRouter.of(context).go('/barcode');
                GoRouter.of(context).go('/inAppPurchase');
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              assetPath: I.alertsIcon,
              text: "Products",
              onTap: () {
                GoRouter.of(context).go('/formScreen');
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              context,
              assetPath: I.settingsIcon,
              text: "In App Purchase",
              onTap: () {
                GoRouter.of(context).go('/inAppPurchase');
              },
            ),
            _buildDrawerItem(
              context,
              assetPath: I.helpIcon,
              text: "Help",
              onTap: () {},
            ),
            _buildDrawerItem(
              context,
              assetPath: I.helpIcon,
              text: "Setting",
              onTap: () {},
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(right: Sizes.p8),
              child: InkWell(
                onTap: () async {
                  context.goNamed(AppRoute.login.getName);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logout successful'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                child: const Text(
                  "Sign Out",
                  style: TextStyle(color: AppColors.warningColor),
                ),
              ),
            ),
            const SizedBox(
              height: Sizes.p16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required String assetPath,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading:
          Image.asset(assetPath, color: Colors.orange, width: 24, height: 24),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}

class _DrawerHeader extends StatefulWidget {
  @override
  __DrawerHeaderState createState() => __DrawerHeaderState();
}

class __DrawerHeaderState extends State<_DrawerHeader> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardSupportProvider>(
      builder: (context, dashboardProvider, _) {
        return DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 6,
                height: MediaQuery.of(context).size.width / 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFFF1F1F1), Color(0xFFF5F5F5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(
                    color: AppColors.color2,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(I.carMenu, width: 50, height: 50),
                ),
              ),
              const SizedBox(width: Sizes.p8),
            ],
          ),
        );
      },
    );
  }
}
