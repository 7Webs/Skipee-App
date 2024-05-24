import 'dart:async';
import 'package:assignment/screens/login/login_screen.dart';
import 'package:assignment/screens/home/home_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    whereToGo();
  }

  void whereToGo() async {
    var pref = await SharedPreferences.getInstance();
    var isLoggedin = pref.getBool("login");
    Timer(const Duration(seconds: 3), () {
      if (isLoggedin != null) {
        if (isLoggedin) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeBottomBar(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 2.5),
          duration: const Duration(seconds: 5),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
