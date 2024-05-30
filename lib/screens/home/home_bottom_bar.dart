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
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedItemColor: const Color(
            0xFF1eb953), // Changed from Colors.green to Color(0xFF1eb953)
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage("assets/images/home.png"),
              color: Color(0xFF1eb953),
            ),
            icon: Image(
              image: AssetImage("assets/images/home.png"),
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage("assets/images/calendar.png"),
              color: Color(0xFF1eb953),
            ),
            icon: Image(
              image: AssetImage("assets/images/calendar.png"),
              color: Colors.grey,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage("assets/images/report.png"),
              color: Color(0xFF1eb953),
            ),
            icon: Image(
              image: AssetImage("assets/images/report.png"),
              color: Colors.grey,
            ),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            activeIcon: Image(
              image: AssetImage("assets/images/profile.png"),
              color: Color(0xFF1eb953),
            ),
            icon: Image(
              image: AssetImage("assets/images/profile.png"),
              color: Colors.grey,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
