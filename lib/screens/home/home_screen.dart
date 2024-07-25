import 'package:assignment/screens/events/saved_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:assignment/models/get_events_model.dart';
import 'package:assignment/repository/events_repo.dart';
import 'package:assignment/screens/events/events_screen.dart';
import 'package:assignment/screens/events/widgets/event_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  List<GetEventsModel> events = [];
  List<GetEventsModel> filterEvents = [];
  String _location = "";

  @override
  void initState() {
    _getEvents();
    _getCurrentLocation();
    super.initState();
  }

  void _getEvents() async {
    setState(() {
      _isLoading = true;
    });
    events = await EventsRepo().getEvents();
    setState(() {
      filterEvents = events;
      _isLoading = false;
    });
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission;
    // Check if location services are enabled
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationServiceEnabled) {
      setState(() {
        _location = 'Services are disabled.';
      });
      return;
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _location = 'Give Location Permission';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _location = 'Give Location Permission';
      });
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Use reverse geocoding to get the address
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    setState(() {
      _location = '${place.locality}, ${place.country}';
    });
  }

  void _filterEvents(String query) {
    if (query.isEmpty) {
      setState(() {
        filterEvents = events;
      });
    } else {
      setState(() {
        filterEvents = events
            .where((event) =>
                event.name!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color(0xFF1eb953).withOpacity(0.5),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/full_logo.png"),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text('Saved Events'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SavedEventsScreen()),
              ),
            ),
            // ListTile(
            //   leading: Icon(Icons.account_circle),
            //   title: Text('Profile'),
            //   onTap: () => Navigator.of(context).push(
            //       MaterialPageRoute(builder: (_) => const ProfileScreen())),
            // ),
            const ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1eb953),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 40), // For status bar padding
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              _scaffoldKey.currentState?.openDrawer();
                            },
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Current Location',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 24,
                                    color: Colors.white,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    onPressed: _getCurrentLocation,
                                  ),
                                ],
                              ),
                              Text(_location),
                            ],
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1eb953),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: IconButton(
                              iconSize: 24,
                              icon: const Icon(Icons.notifications,
                                  color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            const Icon(FontAwesomeIcons.magnifyingGlass,
                                color: Color(0xFF1eb953)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                style: const TextStyle(color: Colors.black),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward,
                                  color: Color(0xFF1eb953)),
                              onPressed: () =>
                                  _filterEvents(searchController.text),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'My Supervisor Events',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
                filterEvents.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/no_events.png',
                              width: 200,
                              height: 300,
                              color: const Color(0xFF1eb953),
                            ),
                            const Text(
                              "No Available Events",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filterEvents.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => EventsScreen(
                                      event: filterEvents[index],
                                    ),
                                  ),
                                );
                              },
                              // child: EventCard(
                              //   date: DateFormat('dd MMMM').format(
                              //       DateTime.parse(
                              //           filterEvents[index].date.toString())),
                              //   time: DateFormat('h:mm a').format(
                              //       DateTime.parse(filterEvents[index]
                              //           .startTime
                              //           .toString())),
                              //   description: filterEvents[index].description!,
                              //   location: filterEvents[index].location!,
                              //   imageUrl: filterEvents[index].image!,
                              //   id: filterEvents[index].sId!,
                              // ),
                              child: EventCard(
                                date: DateFormat('d MMMM').format(
                                    DateTime.parse(filterEvents[index].date!)),
                                startTime: filterEvents[index].startTime!,
                                endTime: filterEvents[index].endTime!,
                                description: filterEvents[index].description!,
                                location: filterEvents[index].location!,
                                imageUrl: filterEvents[index].image!,
                                id: filterEvents[index].sId!,
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
    );
  }
}
