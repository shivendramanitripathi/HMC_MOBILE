import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_configs/string/localizationprovider.dart';
import '../common_widgets/drawer/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/job_model.dart';
import '../services/excel/excel_downloader.dart';
import '../services/pdf/pdf_downloader.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));
  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    final currentIndex = navigationShell.currentIndex;
    final routeLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.toString();
    final noAppBarRoutes = [
      '/formList',
    ];
    final showAppBar =
        !noAppBarRoutes.any((route) => routeLocation.contains(route));
    return Scaffold(
      appBar: showAppBar ? _buildAppBar(context, currentIndex) : null,
      drawer: showAppBar ? const CustomDrawer() : null,
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Work',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tab),
            label: 'Sections',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (int index) => navigationShell.goBranch(index),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, int currentIndex) {
    return AppBar(
      title: Text(_getAppBarTitle(currentIndex)),
      actions: _getAppBarActions(context, currentIndex),
    );
  }

  String _getAppBarTitle(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return 'Dashboard';
      case 1:
        return 'Barcode 2D/3D';
      case 2:
        return 'Visitor Screen';
      default:
        return 'App';
    }
  }

  List<Widget> _getAppBarActions(BuildContext context, int currentIndex) {
    if (currentIndex == 0) {
      final localizationProvider = Provider.of<LocalizationProvider>(context);

      final List<Job> jobList = [
        Job('Developer', Icons.developer_mode),
        Job('Designer', Icons.design_services),
        Job('Consultant', Icons.account_balance),
        Job('Student', Icons.school),
      ];
      return [
        IconButton(
          icon: const Icon(Icons.language),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    AppLocalizations.of(context)!.selectLanguage,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text('English'),
                        onTap: () {
                          localizationProvider
                              .setLocale(const Locale('en', ''));
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        title: const Text('Hindi'),
                        onTap: () {
                          localizationProvider
                              .setLocale(const Locale('hi', ''));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.download),
          onPressed: () {
            downloadPdf(context, jobList);
          },
        ),
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          onPressed: () {
            downloadExcel(jobList);
          },
        ),
      ];
    }
    return [];
  }
}
