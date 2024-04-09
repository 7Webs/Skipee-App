// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:item_count_number_button/item_count_number_button.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:assignment/models/user_model.dart';
import 'package:assignment/services/ticket_services.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? qrData;
  String noOfUsers = "0";
  final GlobalKey _key = GlobalKey();

  void generateQrCode() async {
    String name = widget.user.user!.name!;
    String email = widget.user.user!.email!;
    try {
      String id = await TicketServices().generateTicket(name, email, noOfUsers);
      qrData = id;

      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  void scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      qrData = qrCode;
      if (qrData != null) {
        bool isScanned = await TicketServices().getTicket(qrData!);
        if (isScanned) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Ticket Update'),
                content: const Text('Ticket Scanned Successfully! Approved'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Ticket Update'),
                content: const Text('Ticket Already Used'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    } on PlatformException {
      qrData = "Failed to scan Qr";
    }
  }

  void captureScreenshot() async {
    RenderRepaintBoundary boundary =
        _key.currentContext!.findRenderObject() as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      Timer(const Duration(seconds: 1), () => captureScreenshot);
      return null;
    }
    ui.Image image = await boundary.toImage();

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      Uint8List pngint8 = byteData.buffer.asUint8List();
      final saveImage = await ImageGallerySaver.saveImage(
          Uint8List.fromList(pngint8),
          quality: 90,
          name: 'screenshot-${DateTime.now()}.png');
      log(saveImage.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Screenshot Captured"),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _key,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            IconButton(
              onPressed: () {
                scanQrCode();
              },
              icon: const Icon(
                Icons.qr_code_scanner,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, ${widget.user.user!.name}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                const Text(
                  "Add number of Users",
                  style: TextStyle(fontSize: 18),
                ),
                ItemCount(
                  color: Colors.black12,
                  buttonSizeHeight: 35,
                  textStyle: const TextStyle(fontSize: 16),
                  buttonSizeWidth: 35,
                  initialValue: int.parse(noOfUsers),
                  minValue: 0,
                  maxValue: 10,
                  decimalPlaces: 0,
                  onChanged: (value) {
                    setState(() {
                      noOfUsers = value.toString();
                    });
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    onPressed: () {
                      generateQrCode();
                    },
                    child: const Text(
                      "Generate Ticket Qr Code",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                if (qrData != null)
                  Center(
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: PrettyQrView.data(data: qrData!),
                    ),
                  ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        captureScreenshot();
                      },
                      child: const Text(
                        "Take Screenshot",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
