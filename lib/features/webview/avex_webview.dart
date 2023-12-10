import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvexWebview extends ConsumerStatefulWidget {
  const AvexWebview({super.key});

  @override
  ConsumerState<AvexWebview> createState() => _AvexWebviewState();
}

class _AvexWebviewState extends ConsumerState<AvexWebview> {
  late InAppWebViewController webViewController;
  double progress = 0;
  String url = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://global.transak.com/'),
              ),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  cacheEnabled: true,
                ),
              ),
              onWebViewCreated: (InAppWebViewController controller) {
                webViewController = controller;
              },
              onLoadStart: (InAppWebViewController controller, Uri? url) {
                setState(() {
                  this.url = url.toString();
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
