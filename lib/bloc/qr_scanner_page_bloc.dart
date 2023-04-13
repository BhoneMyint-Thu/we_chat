import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../data/apply/we_chat_apply.dart';
import '../data/apply/we_chat_apply_impl.dart';

class QrScannerPageBloc extends ChangeNotifier{
  ////////////////////////////////////////////
  /////////////////Instances//////////////////
  ////////////////////////////////////////////
  final WeChatApply _apply=WeChatApplyImpl();
  QRViewController ? _qrViewController;
  final _qrKey = GlobalKey(debugLabel: 'QR');

  ////////////////////////////////////////////
  /////////////////Attributes/////////////////
  ////////////////////////////////////////////
  bool _isDispose=false;
  String ? qrResult;

  ////////////////////////////////////////////
  /////////////////Getters////////////////////
  ////////////////////////////////////////////
  QRViewController? get getQRViewController=>_qrViewController;
  GlobalKey get getQrKey=>_qrKey;

  ////////////////////////////////////////////
  /////////////////Setters////////////////////
  ////////////////////////////////////////////
  set setQrController(QRViewController qrViewController){
    _qrViewController=qrViewController;
  }


  ////////////////////////////////////////////
  /////////////////Methods////////////////////
  ////////////////////////////////////////////


  ////////////////////////////////////////////
  /////////////////Constructor////////////////
  ////////////////////////////////////////////


  @override
  void notifyListeners() {
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDispose = true;
    super.dispose();
  }
}