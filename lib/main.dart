import 'package:assignment/common/splash_screen.dart';
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
            seedColor: const Color(0xFF1eb953),
            background: const Color(0xFFe1e7ed),
            onBackground: Colors.white, // Text color set to white
          ),
          useMaterial3: true,
          fontFamily: 'Pippins',
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1eb953),
            ),
          ),
          scaffoldBackgroundColor:
              const Color(0xFFe1e7ed), // Page background color
          textTheme: const TextTheme(
            bodyLarge: TextStyle(
                color: Colors.white,
                fontFamily:
                    'Pippins'), // Default text color for body text with Pippins font
            bodyMedium: TextStyle(
                color: Colors.white,
                fontFamily:
                    'Pippins'), // Default text color for body text with Pippins font
          ),
        ),
        home: const SplashScreen());
  }
}
