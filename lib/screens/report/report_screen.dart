import 'dart:async';

import 'package:assignment/screens/home/home_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                            color: Color(0xFF1eb953),
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
                            Text(
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
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
                                  child: Icon(FontAwesomeIcons.calendarDays,
                                      color: Color(0xFF1eb953)),
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
                                    Icon(Icons.flash_on,
                                        color: Color(0xFF1eb953)),
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
                    ],
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
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
                                            selectedColor: Color(0xFF1eb953),
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
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            filled: true,
                            fillColor: Color(0xFFE1E7ED),
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
                              backgroundColor: Color(0xFF1eb953),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Rectangle shape
                              ),
                            ),
                            child: Text(
                              'Report',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
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
