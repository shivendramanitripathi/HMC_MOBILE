import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class CustomBottomBar extends StatefulWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onWorkOrdersPressed;
  final VoidCallback onProductsPressed;
  final VoidCallback onAccountPressed;
  final VoidCallback onHelpPressed;


  const CustomBottomBar({
    super.key,
    required this.onHomePressed,
    required this.onWorkOrdersPressed,
    required this.onProductsPressed,
    required this.onAccountPressed,
    required this.onHelpPressed,
  });

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;

        return BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF050505),
                  Color(0xFF2F2F2F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, -2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: isSmallScreen
                  ? _buildSmallScreenIcons()
                  : _buildLargeScreenIcons(),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSmallScreenIcons() {
    return [
      _buildIconButton(
        icon: Icons.home,
        label: AppLocalizations.of(context)!.home,
        onPressed: widget.onHomePressed,
      ),
      _buildIconButton(
        icon: Icons.work,
        label: AppLocalizations.of(context)!.work,
        onPressed: (){
          GoRouter.of(context).go('/barcode');
        }
      ),
      _buildIconButton(
        icon: Icons.shopping_bag,
        label: AppLocalizations.of(context)!.products,
        onPressed:(){
          GoRouter.of(context).go('/formScreen');
        },
      ),
      _buildIconButton(
          icon: Icons.account_circle,
          label: AppLocalizations.of(context)!.account,
          onPressed: () {

          }),
    ];
  }

  List<Widget> _buildLargeScreenIcons() {
    return [
      _buildIconButton(
        icon: Icons.home,
        label: "Home",
        onPressed: () {},
      ),
      _buildIconButton(
          icon: Icons.work,
          label: "Work ",
          onPressed: () {
            GoRouter.of(context).go('/barcode');
          }),
      _buildIconButton(
        icon: Icons.shopping_bag,
        label: "Products",
        onPressed: widget.onProductsPressed,
      ),
      _buildIconButton(
        icon: Icons.account_circle,
        label: AppLocalizations.of(context)!.account,
        onPressed: widget.onAccountPressed,
      ),
      _buildIconButton(
        icon: Icons.help,
        label: "Help",
        onPressed: widget.onHelpPressed,
      ),
    ];
  }

  Widget _buildIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return IconButton(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
