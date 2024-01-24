import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:qr_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// import 'package:webview_flutter/webview_flutter.dart';
//
class QRScannerScreen extends StatefulWidget {
  final String barcode;
  QRScannerScreen({super.key, required this.barcode});
  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}
//
// class _QRScannerScreenState extends State<QRScannerScreen> {
//   Future<String> loadImage() async {
//     // Simulate network delay or fetch image from the server
//     await Future.delayed(Duration(seconds: 3));
//
//     return widget.barcode;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     loadImage();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('QRScanner'),
//         // add back button
//         leading: IconButton(
//           onPressed: () {
//             // navigate to the previous screen
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => MyApp(),
//               ),
//             );
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: Center(
//         child: Image.network(widget.barcode),
//       ),
//     );
//   }
// }

//
// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
// class WebViewPage extends StatefulWidget {
//   const WebViewPage({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }

class _QRScannerScreenState extends State<QRScannerScreen> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();

        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('QRScanner'),
            // add back button
            leading: IconButton(
              onPressed: () {
                // navigate to the previous screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Stack(
            children: [
              widget.barcode.contains('http')
                  ? InAppWebView(
                      initialUrlRequest:
                          URLRequest(url: WebUri(widget.barcode)),
                      onWebViewCreated: (InAppWebViewController controller) {
                        inAppWebViewController = controller;
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          _progress = progress / 100;
                        });
                      },
                    )
                  : Center(child: Text(widget.barcode)),
              _progress < 1
                  ? Container(
                      child: LinearProgressIndicator(
                        value: _progress,
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
