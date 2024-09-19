import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_widgets/provider/theme_provider.dart';
import 'app_theme.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_6),
      onPressed: () {
        final themeProvider =
            Provider.of<ThemeProvider>(context, listen: false);
        final currentThemeName = themeProvider.currentThemeName;
        final nextThemeName = _getNextThemeName(currentThemeName);
        themeProvider.setTheme(nextThemeName);
      },
      tooltip: 'Change Theme',
    );
  }

  String _getNextThemeName(String currentThemeName) {
    final themeNames = AppTheme.themes.keys.toList();
    final currentIndex = themeNames.indexOf(currentThemeName);
    final nextIndex = (currentIndex + 1) % themeNames.length;
    return themeNames[nextIndex];
  }
}
