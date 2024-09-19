import 'package:flutter/material.dart';

class BarcodeProvider with ChangeNotifier {
  final List<Map<String, String>> _barcodes = [];

  List<Map<String, String>> get barcodes => _barcodes;

  Map<String, String>? getBarcodeById(String id) {
    return _barcodes.firstWhere((barcode) => barcode['id'] == id, orElse: () => {});
  }
}
