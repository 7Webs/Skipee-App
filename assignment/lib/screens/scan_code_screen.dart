import 'dart:developer';
import 'dart:typed_data';
import 'package:assignment/services/ticket_services.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeScreen extends StatefulWidget {
  const ScanCodeScreen({super.key});

  @override
  State<ScanCodeScreen> createState() => _ScanCodeScreenState();
}

class _ScanCodeScreenState extends State<ScanCodeScreen> {
  bool isScanned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.qr_code,
            ),
          ),
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            log('Barcode found! ${barcode.rawValue}');
          }
          if (image != null) {
            showDialog(
              context: context,
              builder: (context) {
                fetchTicket(barcodes.first.rawValue!);
                return AlertDialog(
                  title: Text(
                    barcodes.first.rawValue ?? "",
                    style: const TextStyle(fontSize: 10),
                  ),
                  content: Column(
                    children: [
                      Image(
                        image: MemoryImage(image),
                      ),
                      isScanned
                          ? const Text("Alraedy used Ticket")
                          : const Text("Ticked Scanned Successfully")
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void fetchTicket(String id) async {
    isScanned = await TicketServices().getTicket(id);

    setState(() {});
  }
}
