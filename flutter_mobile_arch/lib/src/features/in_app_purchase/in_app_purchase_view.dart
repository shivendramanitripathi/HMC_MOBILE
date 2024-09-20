import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/in_app_purchase/provider/in_app_purchase_controller.dart';
import 'package:provider/provider.dart';

class InAppPurchase extends StatelessWidget {
  const InAppPurchase({super.key});
  @override
  Widget build(BuildContext context) {
    final purchaseViewModel = Provider.of<InAppPurchaseController>(context);
    return Scaffold(
      body: purchaseViewModel.isAvailable
          ? _buildProductList(purchaseViewModel)
          : const Center(child: Text('Store is unavailable')),
    );
  }

  Widget _buildProductList(InAppPurchaseController viewModel) {
    return ListView(
      children: viewModel.purchaseModels.map((purchase) {
        return ListTile(
          title: Text(purchase.title),
          subtitle: Text(purchase.description),
          trailing: TextButton(
            onPressed: () {
              viewModel.buyProduct(
                viewModel.products
                    .firstWhere((p) => p.id == purchase.productId),
              );
            },
            child: Text(purchase.price),
          ),
        );
      }).toList(),
    );
  }
}
