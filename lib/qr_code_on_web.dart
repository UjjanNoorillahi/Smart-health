import 'package:flutter/material.dart';
import 'dart:html' as html;

class QRCodeOnWeb extends StatefulWidget {
  final String barcode;
  const QRCodeOnWeb({super.key, required this.barcode});

  @override
  State<QRCodeOnWeb> createState() => _QRCodeOnWebState();
}

class _QRCodeOnWebState extends State<QRCodeOnWeb> {
  initState() {
    super.initState();
    // add 3 seconds delay
    Future.delayed(Duration(seconds: 3), () {
      // call the updateUrl function
      widget.barcode.contains('http')
          ? updateUrl(widget.barcode)
          : updateUrl('');
    });
    updateUrl(widget.barcode);
  }

  void updateUrl(String barcode) {
    // Use the window.location.assign method to set the URL
    html.window.location.assign(barcode);
    // active back button
    html.window.history.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        html.window.history.back();
        return Future.value(false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('Smart health'),
            // back button
            leading: IconButton(
              onPressed: () {
                // navigate to the previous screen
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: widget.barcode.contains('http')
              ? Center(
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     // Pass the barcode value to the updateUrl function
                  //     updateUrl(widget.barcode!);
                  //   },
                  //   child: Text('Update URL with Barcode'),
                  // ),
                  )
              : Center(
                  child: Text(widget.barcode),
                )),
    );
  }
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(
  //         title: const Text('QRScanner'),
  //         // add back button
  //         leading: IconButton(
  //           onPressed: () {
  //             // navigate to the previous screen
  //             Navigator.pop(context);
  //           },
  //           icon: const Icon(Icons.arrow_back),
  //         ),
  //       ),
  //       body: Center(
  //         child: Text(widget.barcode),
  //       ));
  // }
}

// import 'dart:html' as html;
// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatelessWidget {
//   final String barcode = "123456"; // Replace with your barcode value
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Web Search Bar Example'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Pass the barcode value to the updateUrl function
//             updateUrl(barcode);
//           },
//           child: Text('Update URL with Barcode'),
//         ),
//       ),
//     );
//   }
// }
