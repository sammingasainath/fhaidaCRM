import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/shared_provider.dart'; // Import the provider setup
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/auth_phone_screen.dart'; // Ensure you import your other screens

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);

    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Futuristic',
      ),
      home: authStateChanges.when(
        data: (user) {
          if (user != null) {
            return DashboardScreen(); // User authenticated, navigate to Dashboard
          } else {
            return AuthPhoneScreen(); // User not authenticated, navigate to AuthPhoneScreen
          }
        },
        loading: () =>
            SplashScreen(), // Show SplashScreen while checking auth state
        error: (err, stack) =>
            SplashScreen(), // Handle error state, you can customize this
      ),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        // Add other routes here
      },
      onUnknownRoute: (settings) {
        // Handle unknown routes here
        return MaterialPageRoute(builder: (context) => SplashScreen());
      },
    );
  }
}
