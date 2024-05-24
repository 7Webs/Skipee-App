import 'dart:async';

import 'package:assignment/screens/home/home_bottom_bar.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool _isLoading = false;
  List<String> incidentTypes = [
    'Assault',
    'Abuse',
    'Shoving',
    'Others',
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
                  Stack(
                    children: [
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
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
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
                            icon:
                                const Icon(Icons.refresh, color: Colors.white),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Incident Report',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
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
                                const Text(
                                  "Type",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
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
                                                      : null), // Text color changes to white when selected
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
                                            selectedColor: Colors.green,
                                          ))
                                      .toList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Brief Introduction',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          minLines: 3,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Rectangle shape
                              ),
                            ),
                            child: const Text(
                              'Report',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
