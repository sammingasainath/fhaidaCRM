import 'package:anucivil_client/screens/splash_screen.dart';
import 'package:anucivil_client/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Futuristic',
      ),
      home: AppInitializer(), // Check user authentication status first
      routes: {
        '/dashboard': (context) =>
            DashboardScreen(), // Define your dashboard route
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes here
        return MaterialPageRoute(builder: (context) => SplashScreen());
      },
    );
  }
}

class AppInitializer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen(); // Show SplashScreen while checking auth state
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            return DashboardScreen(); // User authenticated, navigate to Dashboard
          } else {
            return SplashScreen(); // User not authenticated, show SplashScreen
          }
        }
      },
    );
  }
}
