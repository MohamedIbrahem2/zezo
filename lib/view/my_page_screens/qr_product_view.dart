import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProductQrImageView extends StatefulWidget {
  const ProductQrImageView(
      {super.key, required this.id, required this.productName});
  final String id;
  final String productName;

  @override
  State<ProductQrImageView> createState() => _ProductQrImageViewState();
}

class _ProductQrImageViewState extends State<ProductQrImageView> {
  final GlobalKey _globalKey = GlobalKey();
  final GlobalKey _qrkey = GlobalKey();
  bool dirExists = false;
  dynamic externalDir = '/storage/emulated/0/Download/Qr_code';

//

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      String fileName = 'qr_code_${widget.productName}';
      int i = 1;
      while (await File('$externalDir/$fileName.png').exists()) {
        fileName = 'qr_code_$i';
        i++;
      }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      //if not then create the path
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      const snackBar = SnackBar(content: Text('QR code saved to gallery'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // open gallery to view the saved QR code
    } catch (e) {
      print(e);
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Something went wrong!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'Product QR Code',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: widget.id));
              const snackBar = SnackBar(content: Text('Copied to clipboard'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: const Icon(Icons.copy, color: Colors.black),
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(
            height: 150,
          ),
          RawMaterialButton(
            shape: const StadiumBorder(),
            fillColor: Colors.blue,
            padding: const EdgeInsets.all(20),
            onPressed: () {},
            child: const Text(
              'Genrate Product QR Code',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: RepaintBoundary(
              key: _qrkey,
              child: QrImageView(
                data: widget.id,
                size: 0.5 * Get.width,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RawMaterialButton(
            shape: const StadiumBorder(),
            fillColor: Colors.blue,
            padding: const EdgeInsets.all(20),
            onPressed: _captureAndSavePng,
            child: const Text(
              'Svee Image to Gallery',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      )),
    );
  }
}
