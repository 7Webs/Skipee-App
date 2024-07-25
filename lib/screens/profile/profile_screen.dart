import 'dart:developer';

import 'package:assignment/common/constants.dart';
import 'package:assignment/models/get_user_model.dart';
import 'package:assignment/repository/auth_repo.dart';
import 'package:assignment/screens/login/login_screen.dart';
import 'package:assignment/screens/profile/edit_profile_screen.dart';
import 'package:assignment/screens/profile/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late GetUserModel userData;
  bool isLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  bool isEditable = false;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")!;
    log(token);
    userData = await AuthServices().getUser(token);

    setState(() {
      nameController.text = userData.name ?? "Name";
      emailController.text = userData.email ?? "Email";
      isLoading = false;
    });
  }

  void logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("login", false);
    pref.remove("email");
    pref.remove("token");
    pref.remove("saved-events");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
    showSnackBar(context, "Logged out successfully", Colors.green.shade400);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1eb953),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 150,
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          radius: 50,
                          child: Text(
                            userData.name![0].toUpperCase(),
                            style: TextStyle(fontSize: 60),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const EditProfileScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit, size: 30),
                      ),
                      // Text(
                      //   "Edit Profile",
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProfileCard(title: "Name", value: userData.name!),
                  ProfileCard(title: "Email", value: userData.email!),
                  // ProfileCard(
                  //     title: "Work In", value: userData.worksIn!.owner!),
                  // ProfileCard(
                  //     title: "Date of Birth", value: userData.birthDate!),
                  ProfileCard(title: "Gender", value: userData.gender!),
                  const SizedBox(height: 60),
                  Center(
                    child: InkWell(
                      onTap: logout,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFF1eb953)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'SIGN OUT',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: const Color(0xFF1eb953)),
                            ),
                            const Icon(
                              Icons.exit_to_app,
                              color: Color(0xFF1eb953),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
