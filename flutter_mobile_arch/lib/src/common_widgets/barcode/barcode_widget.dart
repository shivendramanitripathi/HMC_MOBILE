import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

enum BarcodeType { code128, ean13, qrCode }

class CustomBarcodeWidget extends StatelessWidget {
  final List<String> uniqueIds;
  final BarcodeType barcodeType;
  const CustomBarcodeWidget({ super.key ,required this.uniqueIds, this.barcodeType = BarcodeType.code128});
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.start,
        children: uniqueIds.map((uniqueId) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Barcode for ID: $uniqueId',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: _buildBarcodeWidget(uniqueId),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBarcodeWidget(String uniqueId) {
    switch (barcodeType) {
      case BarcodeType.qrCode:
        return _buildQrCode(uniqueId);
      case BarcodeType.ean13:
        return BarcodeWidget(
          barcode: Barcode.ean13(),
          data: uniqueId,
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(8),
          color: Colors.black,
        );
      case BarcodeType.code128:
      default:
        return BarcodeWidget(
          barcode: Barcode.code128(),
          data: uniqueId,
          width: 140,
          height: 100,
          padding: const EdgeInsets.all(8),
          color: Colors.black,
        );
    }
  }

  QrImageView _buildQrCode(String uniqueId) {
    return QrImageView(
      data: 'This QR code will show the error state instead',
      version: 1,
      size: 200,
      gapless: false,
      errorStateBuilder: (cxt, err) {
        return const Center(
          child: Text(
            'Uh oh! Something went wrong...',
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
