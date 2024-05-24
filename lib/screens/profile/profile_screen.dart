import 'package:assignment/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("login", false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip
                .none, // Allows overflow of children outside the parent stack
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 150,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              const Positioned(
                top: 100, // Positioning it to overlap half of the circle avatar
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/icon.png'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 90),
          Card(
            color: Colors.grey.shade100,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name:'),
                  Text('Holly'),
                  SizedBox(),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Name:'),
                  Text('holly232h'),
                  SizedBox(),
                ],
              ),
            ),
          ),
          Card(
            color: Colors.grey.shade100,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Phone Number:'),
                  Text('989898989'),
                  SizedBox(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: InkWell(
              onTap: logout,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SIGN OUT',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    Icon(
                      Icons.exit_to_app,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
