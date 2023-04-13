import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:we_chat/bloc/qr_scanner_page_bloc.dart';
import 'package:we_chat/constant/dimens.dart';
import 'package:we_chat/pages/qr_scanned_profile_page.dart';
import 'package:we_chat/utils/extension.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QrScannerPageBloc>(
      create: (context) => QrScannerPageBloc(),
      builder: (context, child) => Scaffold(
        body: Center(
          child: QRView(
            key: context.getQrScannerPageBloc().getQrKey,
            overlay: QrScannerOverlayShape(
              borderColor: Colors.white,
              cutOutSize: MediaQuery.of(context).size.width * kQrScannerSize,
              borderRadius: kSP20x,
              borderWidth: kSP5x,
            ),
            onQRViewCreated: (qrViewController) {
              context.getQrScannerPageBloc().setQrController = qrViewController;
              qrViewController.scannedDataStream.listen((event) {
                context.navigateToNextScreenReplace(
                    context,
                    QrScannedProfilePage(
                      uId: event.code,
                    ));
              });
            },
          ),
        ),
      ),
    );
  }
}
