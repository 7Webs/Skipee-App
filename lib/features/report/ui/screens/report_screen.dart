import 'dart:async';
import 'package:assignment/features/events/model/events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key, required this.event});
  final Events event;

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _isLoading = false;

  List<String> incidentTypes = [
    'Assault',
    'Abuse',
    'Shoving',
    'Others',
  ];
  List<String> selectedIncidents = [];
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
          : SingleChildScrollView(
              // Added SingleChildScrollView to prevent overflow
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: NetworkImage(widget.event.image!),
                          fit: BoxFit.cover,
                          opacity: 0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: 230,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat('dd MMMM yyyy').format(
                                          DateTime.parse(
                                            widget.event.date.toString(),
                                          ),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '${DateFormat('EEEE').format(
                                          DateTime.parse(
                                            widget.event.date.toString(),
                                          ),
                                        )}, ${DateFormat('h:mm a').format(
                                          DateTime.parse(
                                            widget.event.startTime.toString(),
                                          ),
                                        )} - ${DateFormat('h:mm a').format(
                                          DateTime.parse(
                                            widget.event.endTime.toString(),
                                          ),
                                        )}',
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Incident Report',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Type",
                                  textAlign: TextAlign.start,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 0,
                                  children: incidentTypes
                                      .map((type) => ChoiceChip(
                                            showCheckmark: false,
                                            label: Text(
                                              type,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: selectedIncidents
                                                          .contains(type)
                                                      ? Colors.white
                                                      : null),
                                            ),
                                            side: BorderSide.none,
                                            selected: selectedIncidents
                                                .contains(type),
                                            onSelected: (bool selected) {
                                              setState(() {
                                                if (selected) {
                                                  selectedIncidents.add(type);
                                                } else {
                                                  selectedIncidents.removeWhere(
                                                      (String name) {
                                                    return name == type;
                                                  });
                                                }
                                              });
                                            },
                                            selectedColor:
                                                const Color(0xFF1eb953),
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Brief Introduction',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 6,
                          decoration: InputDecoration(
                            labelText: 'Messages',
                            labelStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFE1E7ED),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1eb953),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'REPORT',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
