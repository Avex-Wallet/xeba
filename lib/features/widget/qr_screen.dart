import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../core/core.dart';

class QrScreen extends ConsumerStatefulWidget {
  const QrScreen({Key? key, this.title = 'Send'}) : super(key: key);
  final String? title;

  @override
  ConsumerState createState() => _QrScreenState();
}

class _QrScreenState extends ConsumerState<QrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool exit = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(widget.title ?? 'Send',
          style: GoogleFonts.inter()
              .copyWith(fontSize: 22, fontWeight: FontWeight.w500)),
      titleSpacing: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20, weight: 30),
        onPressed: () => context.pop(),
      ),
    );
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            QRView(
              key: qrKey,
              overlay: QrScannerOverlayShape(),
              onQRViewCreated: _onQRViewCreated,
            ),
            appBar,
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Scan the QR code',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Chip(
                        avatar: Icon(
                          Icons.filter_sharp,
                          size: 16,
                        ),
                        label: Card(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final address = scanData.code;
      if (widget.title == 'Social Key Recovery') {
        context.pop(address);
      }
      if (exit) return;
      if (address == null) return;
      if (!address.contains('0x') && !address.startsWith('wc:')) return;
      if (address.startsWith("wc:")) {
        exit = true;
        context.pop(address.substring(address.indexOf("wc:")));
      } else {
        exit = true;
        context.pop(address.substring(address.indexOf('0x')));
        showSnackBar(context, scanData.code ?? '');
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
