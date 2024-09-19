import 'package:flutter/material.dart';

import '../app_configs/app_images.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        AppImages.loadingIcon,
        width: 50,
        height: 50,
      ),
    );
  }
}
