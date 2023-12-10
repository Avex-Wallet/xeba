import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:avex_mobile/features/connected_app/utils/constants.dart';

class QRScanSheet extends StatefulWidget {
  const QRScanSheet({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<QRScanSheet> createState() => _QRScanSheetState();
}

class _QRScanSheetState extends State<QRScanSheet> {
  bool first = true;
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.7,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.white60, width: 2),
      ),
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Positioned(
              top: StyleConstants.magic40,
              child: Text(
                widget.title,
                style: StyleConstants.titleText,
              ),
            ),
            Positioned(
              top: StyleConstants.magic40,
              right: StyleConstants.magic40,
              child: Container(
                width: StyleConstants.magic40,
                height: StyleConstants.magic40,
                decoration: const BoxDecoration(
                  color: StyleConstants.layerColor0,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      StyleConstants.magic20,
                    ),
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: StyleConstants.primaryColor,
                  ),
                  iconSize: StyleConstants.magic40,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Center(
              child: MobileScanner(
                controller: controller,
                onDetect: (barcode) async {
                  // If the barcode has a value, return it and pop the sheet
                  if (barcode.barcodes.isNotEmpty &&
                      barcode.barcodes.first.rawValue != null &&
                      first) {
                    first = false;
                    Navigator.of(context).pop(barcode.barcodes.first.rawValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
