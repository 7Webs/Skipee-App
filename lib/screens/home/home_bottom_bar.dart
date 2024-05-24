import 'package:assignment/screens/events/events_screen.dart';
import 'package:assignment/screens/home/home_screen.dart';
import 'package:assignment/screens/profile/profile_screen.dart';
import 'package:assignment/screens/report/report_screen.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key, this.index});
  final int? index;

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      const EventsScreen(),
      const ReportScreen(),
      const ProfileScreen(),
    ];
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
