import 'dart:developer';
import 'package:assignment/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = "User";
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      log("here");
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  void getValue() async {
    var pref = await SharedPreferences.getInstance();
    userName = pref.getString("name")!;
    setState(() {});
  }

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
    List<IconData> icons = [
      Icons.call,
      Icons.email,
      Icons.support_agent,
      Icons.logout,
    ];

    List<String> headline = ["CALL US", "EMAIL US", "ABOUT US", "LOG OUT"];

    void onClick(int index) {
      if (index == 0) {
        _launchUrl('tel:9377403463');
      } else if (index == 1) {
        _launchUrl('mailto:support@example.com');
      } else if (index == 2) {
      } else if (index == 3) {
        logout();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Report"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              height: MediaQuery.of(context).size.height * .25,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Icon(
                      Icons.person,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    userName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.separated(
                  itemCount: headline.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: ((context, index) {
                    return ListTile(
                      onTap: () => onClick(index),
                      title: Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 30,
                            foregroundColor: Colors.green,
                            backgroundColor: Colors.white,
                            child: Icon(
                              icons[index],
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            headline[index],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
