import 'package:assignment/extras/list_tickets_screen.dart';
import 'package:assignment/features/tickets/repo/ticket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String selectedFilter = 'ALL';
  int totalTickets = 50;
  int scannedTickets = 0;
  String? qrData;

  Future<void> _refreshPage() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      totalTickets = 30;
      scannedTickets = 20;
    });
  }

  void _scanTicket() async {
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
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: const Text('Event X'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshPage,
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.post_add_sharp,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    'Ticket type: $selectedFilter',
                    style: TextStyle(color: Colors.white),
                  ),
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    iconSize: 24,
                    underline: Container(),
                    style: const TextStyle(color: Colors.white),
                    borderRadius: BorderRadius.zero,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedFilter = newValue!;
                      });
                    },
                    items: <String>['ALL', 'CHEAP', 'COSTLY', 'MEDIUM']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey.shade900),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$totalTickets',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Remaining',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ListTicketsScreen(),
                                ),
                              );
                            },
                            child: const Text('View list'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.grey.shade900),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$scannedTickets',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Admitted',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('View list'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 80,
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: _scanTicket,
                icon: const Icon(Icons.qr_code_scanner),
                label: const Text('SCAN A TICKET'),
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
