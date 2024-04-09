import 'package:assignment/models/user_model.dart';
import 'package:assignment/screens/home_screen.dart';
import 'package:assignment/screens/signup_screen.dart';
import 'package:assignment/services/auth_services.dart';
import 'package:assignment/widgets/resuable.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  void loginButton() async {
    if (_emailTextController.text.isEmpty ||
        _passwordTextController.text.isEmpty) {
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
          .loginUser(_emailTextController.text, _passwordTextController.text);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Logged in Successfully"),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.fixed,
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: userData,
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors(),
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: [
                logoWidget('assets/images/logo.png'),
                const SizedBox(height: 30),
                resuableTextField('Enter your email', Icons.person_2_outlined,
                    false, _emailTextController),
                const SizedBox(height: 20),
                resuableTextField('Enter your password', Icons.lock_outline,
                    true, _passwordTextController),
                const SizedBox(height: 20),
                signinSignupButton(context, true, () {
                  loginButton();
                }),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account? ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
