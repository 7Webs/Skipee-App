//import 'package:assignment/features/events/ui/screens/events_screen.dart';
import 'package:assignment/features/home/home_screen.dart';
import 'package:assignment/features/profile/ui/screens/profile_screen.dart';
//import 'package:assignment/features/report/ui/screens/report_screen.dart';
import 'package:flutter/material.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  State<HomeBottomBar> createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      // EventsScreen(),
      // ReportScreen(),
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
          // BottomNavigationBarItem(
          //   activeIcon: Image(
          //     image: AssetImage("assets/images/calendar.png"),
          //     color: Color(0xFF1eb953),
          //   ),
          //   icon: Image(
          //     image: AssetImage("assets/images/calendar.png"),
          //     color: Colors.grey,
          //   ),
          //   label: 'Events',
          // ),
          // BottomNavigationBarItem(
          //   activeIcon: Image(
          //     image: AssetImage("assets/images/report.png"),
          //     color: Color(0xFF1eb953),
          //   ),
          //   icon: Image(
          //     image: AssetImage("assets/images/report.png"),
          //     color: Colors.grey,
          //   ),
          //   label: 'Report',
          // ),
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
