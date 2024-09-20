import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../models/in_app_purchase_model.dart';

class InAppPurchaseController with ChangeNotifier {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool isAvailable = false;
  List<ProductDetails> products = [];
  List<PurchaseDetails> purchases = [];
  bool purchasePending = false;

  InAppPurchaseController() {
    _initialize();
  }

  Future<void> _initialize() async {
    isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      return;
    }

    const Set<String> productIds = {'product_id_1', 'product_id_2'};
    final ProductDetailsResponse response =
    await _inAppPurchase.queryProductDetails(productIds);

    if (response.error == null) {
      products = response.productDetails;
    } else {
    }

    _inAppPurchase.purchaseStream.listen(_onPurchaseUpdated);
    notifyListeners();
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (PurchaseDetails purchase in purchaseDetailsList) {
      if (purchase.status == PurchaseStatus.purchased) {
        _handlePurchase(purchase);
      } else if (purchase.status == PurchaseStatus.error) {
      }
    }
    notifyListeners();
  }

  void _handlePurchase(PurchaseDetails purchase) {
    purchases.add(purchase);
  }

  void buyProduct(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  List<PurchaseModel> get purchaseModels {
    return products.map((product) {
      return PurchaseModel(
        productId: product.id,
        title: product.title,
        description: product.description,
        price: product.price,
      );
    }).toList();
  }
}
