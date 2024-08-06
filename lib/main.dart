import 'package:anucivil_client/forms/property_form.dart';
import 'package:anucivil_client/screens/dummy_profile.dart';
import 'package:anucivil_client/widgets/daily_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/screens/dummy_chat_screen.dart';
import 'package:anucivil_client/screens/dummy_feed.dart';
import 'package:anucivil_client/screens/project_details_form.dart';
import 'package:anucivil_client/screens/user_details_screen.dart';
import 'package:anucivil_client/screens/splash_screen.dart';
import 'package:anucivil_client/screens/dashboard_screen.dart';
import 'package:anucivil_client/screens/signin_screen(new).dart';
import 'package:anucivil_client/screens/signup_screen(new).dart';
import 'package:anucivil_client/widgets/bottomNavbar.dart';
import 'package:anucivil_client/providers/shared_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    final List<Widget> _screens = [
      DashboardScreen(),
      EventCalendarView(), // Replace with your other screens
      PropertyFormScreen(),
      DummyAlertsScreen(),
      DummyChatScreen()
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fhaidaCRM',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Futuristic',
      ),
      home: authState.when(
        data: (isAuthenticated) {
          if (isAuthenticated) {
            return BottomNavBar(screens: _screens);
          } else {
            return SignInScreen();
          }
        },
        loading: () => SplashScreen(),
        error: (_, __) => SplashScreen(),
      ),
      routes: {
        '/dashboard': (context) => BottomNavBar(screens: _screens),
        '/signin': (context) => SignInScreen(),
        '/signup': (context) => SignUpScreen(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => SplashScreen());
      },
    );
  }
}
