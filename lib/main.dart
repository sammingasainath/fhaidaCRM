import 'package:anucivil_client/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/dashboard_screen.dart';
import 'widgets/bottomNavbar.dart'; // Import your BottomNavBar widget here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Your App Name',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: 'Futuristic',
        ),
        home: Scaffold(
          body: SplashScreen(), // Set your initial screen here
          // bottomNavigationBar: BottomNavBar(), // Add your BottomNavBar here
        ),
      ),
    );
  }
}
