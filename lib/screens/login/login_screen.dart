import 'package:assignment/models/user_model.dart';
import 'package:assignment/screens/home/home_bottom_bar.dart';
import 'package:assignment/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    void loginButton() async {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Enter the required fields"),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.fixed,
          ),
        );
        return;
      }
      try {
        UserModel userData = await AuthServices()
            .loginUser(emailController.text, passwordController.text);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Logged in Successfully"),
            backgroundColor: Colors.green.shade400,
            behavior: SnackBarBehavior.fixed,
          ),
        );
        var pref = await SharedPreferences.getInstance();
        pref.setBool("login", true);
        pref.setString("name", userData.user!.name!);

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                ).animate(animation),
                child: const HomeBottomBar(),
              );
            },
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Some Error occured"),
            backgroundColor: Colors.red.shade400,
            behavior: SnackBarBehavior.fixed,
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Stack(
              children: [
                // Background image with a custom shape and blur effect
                Container(
                  height: 220, // Increased height for more coverage on the left
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login_top.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Main content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(flex: 2),
                      // Logo moved further down
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 90.0), // Increased top padding
                        child: Image.asset('assets/images/full_logo.png',
                            height: 80),
                      ),
                      const SizedBox(height: 16),
                      // Subtitle
                      const Text(
                        'Entrance supervisor',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Email text field centered and width reduced
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: emailController,
                          style: TextStyle(
                            color: Colors.black, // Changed text color to black
                          ),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Password text field centered and width reduced
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: passwordController,
                          style: TextStyle(
                            color: Colors.black, // Changed text color to black
                          ),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Forgotten password button styled
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgotten password?',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Login button styled as rectangle with white text color
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loginButton,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(20), // Rectangle shape
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
