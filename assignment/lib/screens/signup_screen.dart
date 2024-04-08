import 'package:assignment/screens/signin_screen.dart';
import 'package:assignment/services/auth_services.dart';
import 'package:assignment/widgets/resuable.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  void signUpButton() async {
    if (_userNameTextController.text.isEmpty ||
        _emailTextController.text.isEmpty ||
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
      bool isSuccessfull = await AuthServices().registerUser(
          _userNameTextController.text,
          _emailTextController.text,
          _passwordTextController.text);
      if (isSuccessfull) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Registered Successfully"),
            backgroundColor: Colors.green.shade400,
            behavior: SnackBarBehavior.fixed,
          ),
        );
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Error in registeration"),
          backgroundColor: Colors.green.shade400,
          behavior: SnackBarBehavior.fixed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              resuableTextField("Enter username", Icons.person_outlined, false,
                  _userNameTextController),
              const SizedBox(height: 20),
              resuableTextField("Enter Email id", Icons.email_outlined, false,
                  _emailTextController),
              const SizedBox(height: 20),
              resuableTextField("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
              const SizedBox(height: 20),
              signinSignupButton(context, false, () {
                signUpButton();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
