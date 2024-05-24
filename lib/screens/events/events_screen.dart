// ignore_for_file: use_build_context_synchronously

import 'package:assignment/screens/events/ticket_approval_screen.dart';
import 'package:assignment/screens/home/home_bottom_bar.dart';
import 'package:assignment/services/ticket_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _isLoading = false;
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
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const TicketApprovalScreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.green.shade300,
                content: const Text(
                  'NO TICKET FOUND',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
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

  void _refreshScreen() {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network request or other asynchronous operation
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Stack(
                  children: [
                    // Top curved image container
                    Container(
                      height: 220,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          filterQuality: FilterQuality.high,
                          image: AssetImage('assets/images/event_image.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),

                    // Back arrow and refresh icons
                    Positioned(
                      top: 40,
                      left: 16,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const HomeBottomBar()));
                        },
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 16,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          iconSize: 24, // Reduced icon size
                          icon: const Icon(Icons.refresh, color: Colors.white),
                          onPressed: _refreshScreen,
                        ),
                      ),
                    ),
                    // Event description and other details
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.calendar_today,
                                    color: Colors.green),
                              ),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '10 JUNE 2024',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Tuesday, 6:30PM - 9:00PM',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Row(
                                children: [
                                  Icon(Icons.flash_on, color: Colors.green),
                                  SizedBox(width: 4),
                                  Text(
                                    '50',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Other content goes here
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple.shade800,
                              Colors.purple.shade300
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Queue Skips',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remaining',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  '50',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Admitted',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Text('20',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: MediaQuery.of(context).size.height / 5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.green.shade800,
                              Colors.green.shade300
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Entry Tickets',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Remaining',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  '45',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Admitted',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white)),
                                Text('22',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20), // Increased space
                      // Verify Ticket button
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: scanQrCode,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Icon(Icons.qr_code,
                                    color: Colors.black, size: 30),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text('VERIFY TICKET',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
