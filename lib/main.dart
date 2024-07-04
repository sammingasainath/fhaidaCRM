import 'package:anucivil_client/screens/dummy_chat_screen.dart';
import 'package:anucivil_client/screens/dummy_feed.dart';
import 'package:anucivil_client/screens/dummy_profile.dart';
import 'package:anucivil_client/screens/project_details_form.dart';
import 'package:anucivil_client/screens/user_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/shared_provider.dart'; // Import the provider setup
import 'screens/splash_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/auth_phone_screen.dart'; // Ensure you import your other screens
import 'widgets/bottomNavbar.dart';
// Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChanges = ref.watch(authStateChangesProvider);
    final userDetailsComplete =
        ref.watch(userDetailsCompleteProvider); // Add this provider

    final List<Widget> _screens = [
      DashboardScreen(),
      DummyFeedsScreen(), // Replace with your other screens
      ProjectDetailsForm(),
      DummyAlertsScreen(),
      DummyChatScreen()
    ];

    return MaterialApp(
      title: 'AnuCivil',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Futuristic',
      ),
      home: authStateChanges.when(
        data: (user) {
          if (user != null) {
            return userDetailsComplete.when(
              data: (isComplete) {
                if (isComplete) {
                  return BottomNavBar(screens: _screens);
                } else {
                  return UserDetailsScreen();
                }
              },
              loading: () => SplashScreen(),
              error: (err, stack) => SplashScreen(),
            );
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
