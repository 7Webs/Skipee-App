import 'package:assignment/screens/events/saved_events_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:assignment/models/events.dart';
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
  List<Events> events = [];
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

  @override
  Widget build(BuildContext context) {
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
                        child: const Row(
                          children: [
                            Icon(FontAwesomeIcons.magnifyingGlass,
                                color: Color(0xFF1eb953)),
                            SizedBox(width: 8),
                            Expanded(
                              child: TextField(
                                style: TextStyle(color: Colors.black),
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
                events.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/images/no_events.png',
                              fit: BoxFit.cover,
                              width: 300,
                              color: const Color(0xFF1eb953),
                            ),
                            Text(
                              "No Events Found",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.green),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: events.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => EventsScreen(
                                      event: events[index],
                                    ),
                                  ),
                                );
                              },
                              child: EventCard(
                                date: DateFormat('dd MMMM').format(
                                    DateTime.parse(
                                        events[index].date.toString())),
                                time: DateFormat('h:mm a').format(
                                    DateTime.parse(
                                        events[index].startTime.toString())),
                                description: events[index].description!,
                                location: events[index].location!,
                                imageUrl: events[index].image!,
                                id: events[index].id!,
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
