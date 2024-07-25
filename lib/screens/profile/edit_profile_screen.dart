import 'package:assignment/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assignment/repository/auth_repo.dart';
import 'package:assignment/models/get_user_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final newPasswordController = TextEditingController();
  bool isLoading = false;
  late GetUserModel userData;
  String token = "";

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoading = true;
    });
    var pref = await SharedPreferences.getInstance();
    token = pref.getString("token")!;
    userData = await AuthServices().getUser(token);
    setState(() {
      nameController.text = userData.name!;
      emailController.text = userData.email!;
      isLoading = false;
    });
  }

  void submit() async {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      showSnackBar(
          context, "Name and Email cannot be empty", Colors.red.shade400);

      return;
    } else {
      try {
        await AuthServices().updateUser(nameController.text,
            newPasswordController.text, token, emailController.text);
        showSnackBar(context, "Profile Updated", Colors.green.shade400);

        Navigator.of(context).pop();
        return;
      } catch (e) {
        showSnackBar(context, "Some Error Occurred While Updating Profile",
            Colors.red.shade400);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xFF1eb953),
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ), // Set label text color to black
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: Colors
                                  .black), // Set label text color to black
                        ),
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: newPasswordController,
                        decoration: const InputDecoration(
                          labelText: "New Password",
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: Colors
                                  .black), // Set label text color to black
                        ),
                        obscureText: true,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1eb953),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rectangle shape
                            ),
                          ),
                          child: Text(
                            'SUBMIT',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
