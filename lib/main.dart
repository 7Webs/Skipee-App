import 'package:assignment/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '7 Webs',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            background: Colors.grey.shade300,
          ),
          useMaterial3: true,
          fontFamily:
              'Roboto',
        ),
        home: const SplashScreen());
  }
}
