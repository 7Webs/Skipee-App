import 'dart:async';
import 'package:assignment/models/events.dart';
import 'package:assignment/models/ticket_data.dart';
import 'package:assignment/screens/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen(
      {super.key, required this.isTickets, required this.event});
  final bool isTickets;
  final Events event;

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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(widget.event.image!),
                        fit: BoxFit.cover,
                        opacity: 0.5),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 290,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Container(
                            height: 37,
                            width: 37,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 29, 168, 78),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: IconButton(
                              iconSize: 24,
                              icon: const Icon(Icons.refresh,
                                  color: Colors.white),
                              onPressed: _refreshScreen,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.event.description!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                                  child: Image.asset(
                                    'assets/images/calendar.png',
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(
                                              widget.event.date.toString())),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${DateFormat('EEEE').format(DateTime.parse(widget.event.date.toString()))}, ${DateFormat('h:mm a').format(DateTime.parse(widget.event.startTime.toString()))} - ${DateFormat('h:mm a').format(DateTime.parse(widget.event.endTime.toString()))}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/flash.png",
                                      width: 30,
                                      height: 30,
                                    ),
                                    Text(
                                      widget.event.tickets.length.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: const Row(
                                children: [
                                  Icon(FontAwesomeIcons.magnifyingGlass,
                                      color: Color(0xFF1eb953)),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        hintText: 'Search...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
