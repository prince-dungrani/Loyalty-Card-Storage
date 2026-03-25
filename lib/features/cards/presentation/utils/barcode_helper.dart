import 'package:barcode_widget/barcode_widget.dart';

class BarcodeHelper {
  static Barcode getBarcodeFromType(String type) {
    switch (type.toUpperCase()) {
      case 'QR_CODE':
        return Barcode.qrCode();
      case 'EAN_13':
        return Barcode.ean13();
      case 'EAN_8':
        return Barcode.ean8();
      case 'UPC_A':
        return Barcode.upcA();
      case 'UPC_E':
        return Barcode.upcE();
      case 'CODE_39':
        return Barcode.code39();
      case 'CODE_93':
        return Barcode.code93();
      case 'ITF':
        return Barcode.itf();
      case 'DATA_MATRIX':
        return Barcode.dataMatrix();
      case 'PDF417':
        return Barcode.pdf417();
      case 'AZTEC':
        return Barcode.aztec();
      case 'CODE_128':
      default:
        return Barcode.code128();
    }
  }

  static const List<String> supportedTypes = [
    'CODE_128',
    'QR_CODE',
    'EAN_13',
    'UPC_A',
    'CODE_39',
    'DATA_MATRIX',
  ];
}
