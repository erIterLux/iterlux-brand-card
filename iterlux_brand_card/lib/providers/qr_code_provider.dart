import 'package:flutter/material.dart';
import 'package:iterlux_brand_card/models/qr_code.dart';
import 'package:iterlux_brand_card/services/qr_code_data_service.dart';

class QrCodeProvider extends ChangeNotifier {
  final QrCodeDataService _dataService;
  List<QrCode> qrCodes = [];
  QrCode? defaultQrCode;
  bool isBusy = false;
  bool hasDefault = false;

  QrCodeProvider(this._dataService);

  Future<void> loadQrCodes() async {
    isBusy = true;
    notifyListeners();
    qrCodes = await _dataService.getQrCodes();
    defaultQrCode = await _dataService.getDefaultQrCode();
    hasDefault = defaultQrCode != null;
    isBusy = false;
    notifyListeners();
  }

  Future<void> addQrCode(QrCode qrCode) async {
    await _dataService.saveQrCode(qrCode);
    qrCodes.add(qrCode);
    notifyListeners();
  }

  Future<void> setDefaultQrCode(QrCode qrCode) async {
    await _dataService.setDefaultQrCode(qrCode);
    defaultQrCode = qrCode;
    hasDefault = true;
    notifyListeners();
  }

  Future<void> deleteQrCode(QrCode qrCode) async {
    await _dataService.deleteQrCode(qrCode);
    qrCodes.remove(qrCode);
    if (qrCode.isDefault) {
      defaultQrCode = qrCodes.isNotEmpty ? qrCodes.first : null;
      hasDefault = defaultQrCode != null;
    }
    notifyListeners();
  }

  // Add more methods as needed (e.g., sync)
}