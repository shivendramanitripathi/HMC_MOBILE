import 'package:flutter/material.dart';

import 'custom_bottom_tab_bars.dart';

class CustomBarsButton extends StatefulWidget {
   const CustomBarsButton({super.key});

  @override
  State<CustomBarsButton> createState() => _CustomButtomBarsButtonState();
}

class _CustomButtomBarsButtonState extends State<CustomBarsButton> {
  int selectedIndex = 0;

  void _onHomePressed() {}

  void _onWorkOrdersPressed() {}

  void _onProductsPressed() {}

  void _onAccountPressed() {}

  void _onHelpPressed() {}
  @override
  Widget build(BuildContext context) {
    return CustomBottomBar(
      onHomePressed: () {
        setState(() {
          selectedIndex = 0;
          _onHomePressed();
        });
      },
      onWorkOrdersPressed: () {
        setState(() {
          selectedIndex = 1;
          _onWorkOrdersPressed();
        });
      },
      onProductsPressed: () {
        setState(() {
          selectedIndex = 2;
          _onProductsPressed();
        });
      },
      onAccountPressed: () {
        setState(() {
          selectedIndex = 3;
          _onAccountPressed();
        });
      },
      onHelpPressed: () {
        setState(() {
          selectedIndex = 4;
          _onHelpPressed();
        });
      },
    );
  }
}
