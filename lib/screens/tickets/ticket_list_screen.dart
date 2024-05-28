import 'dart:async';

import 'package:assignment/screens/home/home_bottom_bar.dart';
import 'package:assignment/screens/tickets/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key, required this.isTickets});
  final bool isTickets;

  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  bool _isLoading = false;
  List<Map<String, dynamic>> dummyData = [
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Dinesh Sharma',
      'username': 'dineshsharma785',
      'tickets': 10,
    },
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Holly',
      'username': 'holly654354',
      'tickets': 4,
    },
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Henry',
      'username': 'Henry25121326',
      'tickets': 5,
    },
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Imogen',
      'username': 'Imogen9878',
      'tickets': 8,
    },
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Thomas',
      'username': 'thomas66936',
      'tickets': 10,
    },
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Jacqueline',
      'username': 'Jacqueline6545454',
      'tickets': 12,
    },
    {
      'imageUrl': 'assets/images/event_image.jpg',
      'name': 'Katherine',
      'username': 'Katherine65965',
      'tickets': 15,
    },
  ];

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
                    Container(
                      height: 265,
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
                              builder: (_) => const HomeBottomBar(
                                index: 1,
                              ),
                            ),
                          );
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
                          color: const Color(
                              0xFF1eb953), // Changed to hex color code
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
                      bottom:
                          80, // Adjusted position to accommodate search container
                      left: 16,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(FontAwesomeIcons.calendarDays,
                                    color: Color(
                                        0xFF1eb953)), // Changed to hex color code
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '10 JUNE 2024',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Tuesday, 6:30PM - 9:00PM',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    size: 20,
                                    widget.isTickets
                                        ? FontAwesomeIcons.ticket
                                        : Icons.flash_on,
                                    color: const Color(0xFF1eb953),
                                  ), // Changed to hex color code
                                  const SizedBox(width: 4),
                                  Text(
                                    '50',
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
                        ],
                      ),
                    ),
                    // Search container positioned within the image
                    Positioned(
                      bottom: 16,
                      left: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                          Icon(
                            size: 20,
                            widget.isTickets
                                ? FontAwesomeIcons.ticket
                                : Icons.flash_on,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 4),
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
                        imageUrl: data['imageUrl'],
                        name: data['name'],
                        username: data['username'],
                        tickets: data['tickets'],
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
