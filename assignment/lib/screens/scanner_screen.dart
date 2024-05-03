import 'package:assignment/services/ticket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String? qrData;
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
        } else if (!isScanned) {
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
        } else {
          return;
        }
      }
    } on PlatformException {
      qrData = "Failed to scan Qr";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: ElevatedButton(
            child: Text('Scan QR'),
            onPressed: scanQrCode,
          ),
        ),
      ),
    );
  }
}
