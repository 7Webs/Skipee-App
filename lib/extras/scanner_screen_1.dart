import 'package:analog_clock/analog_clock.dart';
import 'package:assignment/repository/ticket_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen1 extends StatefulWidget {
  const ScannerScreen1({super.key});

  @override
  State<ScannerScreen1> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen1> {
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
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Verify Ticket"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/scanner.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const Text(
            "Verify Ticket Here",
            style: TextStyle(
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
          ),
          const Text("Scan the QR Code to Verify the Ticket"),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: AnalogClock(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 5.0, color: Colors.black),
                        color: Colors.black,
                        shape: BoxShape.circle),
                    isLive: true,
                    hourHandColor: Colors.white,
                    minuteHandColor: Colors.white,
                    showSecondHand: true,
                    numberColor: Colors.white,
                    showNumbers: true,
                    textScaleFactor: 1.5,
                    showTicks: true,
                    showDigitalClock: true,
                    digitalClockColor: Colors.white,
                    datetime: DateTime(2020, 8, 4, 9, 11, 0),
                  ),
                ),
                ElevatedButton(
                  onPressed: scanQrCode,
                  child: const Text('Scan Here'),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
