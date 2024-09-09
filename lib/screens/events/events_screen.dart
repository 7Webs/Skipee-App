import 'dart:developer';

import 'package:assignment/common/constants.dart';
import 'package:assignment/common/widgets/event_appbar.dart';
import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/models/get_ticket_model.dart';
import 'package:assignment/screens/events/widgets/total_users_bottomsheet.dart';
import 'package:assignment/screens/report/report_screen.dart';
import 'package:assignment/screens/tickets/ticket_list_screen.dart';
import 'package:assignment/screens/tickets/widgets/ticket_qr_details_bottom_sheet.dart';
import 'package:assignment/repository/ticket_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:assignment/common/widgets/not_fount.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key, required this.event});
  final GetEventsModel event;

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  bool _isLoading = false;
  String? qrData;

  void showticketDetails(
      BuildContext context, GetTicketModel ticket, GetEventsModel event) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          TicketQrDetailsBottomSheet(ticket: ticket, event: event),
    );
  }

  Future<int?> showNumberOfUsers(BuildContext context, int totalUsers) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (context) => TotalUsersBottomSheet(totalUsers: totalUsers),
    );
  }

  void scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      qrData = qrCode;
      if (qrData != null) {
        GetTicketModel ticket = await TicketRepo().scanTicket(qrData!);
        log(qrData!);
        if (ticket.entered! < ticket.noOfUser!) {
          int ans = await showNumberOfUsers(
                  context, (ticket.noOfUser! - ticket.entered!)) ??
              0;
          if (ans > 0) {
            GetTicketModel ticketNew =
                await TicketRepo().approveTicket(qrData!, ans);
            showticketDetails(context, ticketNew, widget.event);
          } else {
            return;
          }
        } else if (ticket.entered == ticket.noOfUser) {
          showAlertDialog(context, "TICKET ALREADY SCANNED");
        } else {
          showAlertDialog(context, "NO TICKET FOUND");
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
    final theme = Theme.of(context);
    bool isGreen = true;
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                EventAppbar(
                  event: widget.event,
                  onPressed: _refreshScreen,
                  haveSearch: false,
                ),
                Expanded(
                  child: widget.event.tickets == null ||
                          widget.event.tickets!.isEmpty
                      ? const NotFoundWidget(message: "No Tickets Found")
                      : ListView.builder(
                          itemCount: widget.event.tickets!.length,
                          itemBuilder: (context, index) {
                            isGreen = !isGreen;
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => TicketListScreen(
                                      event: widget.event,
                                      ticketIndex: index,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: isGreen
                                        ? const AssetImage(
                                            'assets/images/ticket_card.png')
                                        : const AssetImage(
                                            'assets/images/queue_card.png'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.event.tickets![index].name!,
                                      style: theme.textTheme.headlineMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
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
                              child: Image.asset(
                                'assets/images/scanner.png',
                                width: 30,
                                height: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'VERIFY TICKET',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ReportScreen(
                                    event: widget.event,
                                  ),
                                ),
                              );
                            },
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
                              child: const Icon(
                                Icons.report,
                                size: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'REPORT',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
    );
  }
}
