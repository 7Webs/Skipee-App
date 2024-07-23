import 'dart:async';
import 'package:assignment/common/widgets/event_appbar.dart';
import 'package:assignment/extras/ticket_data.dart';
import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/screens/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';


class TicketListScreen extends StatefulWidget {
  const TicketListScreen(
      {super.key, required this.isTickets, required this.event});
  final bool isTickets;
  final GetEventsModel event;

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  bool _isLoading = false;
  List<TicketData> dummyData = TicketData.dummyData;

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
                EventAppbar(
                  event: widget.event,
                  onPressed: _refreshScreen,
                  haveSearch: true,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.isTickets ? 'Entry Tickets' : 'Queue Skips',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            widget.isTickets
                                ? "assets/images/ticket.png"
                                : "assets/images/flash.png",
                            color: Colors.black,
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            '50',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: dummyData.map((data) {
                      return TicketListCardWidget(
                        imageUrl: data.imageUrl,
                        name: data.name,
                        username: data.username,
                        tickets: data.tickets,
                        isTicket: widget.isTickets,
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
