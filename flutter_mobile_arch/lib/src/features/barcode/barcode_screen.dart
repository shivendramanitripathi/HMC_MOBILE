import 'package:flutter/material.dart';
import 'package:flutter_mobile_arch/src/features/barcode/provider/barcode_provider.dart';
import 'package:provider/provider.dart';
import '../../common_widgets/barcode/barcode_widget.dart';

class BarcodeScreen extends StatelessWidget {
  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BarcodeProvider(),
        child: const Scaffold(
          body: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(children: [
                Expanded(
                  child: CustomBarcodeWidget(
                    uniqueIds: [
                      '123456789012',
                      '987654321098',
                      '987654321098',
                      "987654321098"
                    ],
                    barcodeType: BarcodeType.code128,
                  ),
                ),
              ])),
        ));
  }
}
