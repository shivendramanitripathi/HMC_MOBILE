import 'package:g_json/g_json.dart';

class PurchaseModel {
  final String productId;
  final String title;
  final String description;
  final String price;

  PurchaseModel({
    required this.productId,
    required this.title,
    required this.description,
    required this.price,
  });

  PurchaseModel.fromJson(JSON json)
      : productId = json['productId'].stringValue,
        title = json['title'].stringValue,
        description = json['description'].stringValue,
        price = json['price'].stringValue;

  JSON toJson() {
    return JSON({
      'productId': productId,
      'title': title,
      'description': description,
      'price': price,
    });
  }
}
