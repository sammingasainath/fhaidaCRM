import 'package:fhaidaCrm/forms/models.dart';
import 'package:fhaidaCrm/forms/property_form.dart';
import 'package:fhaidaCrm/screens/dummy_profile.dart';
import 'package:fhaidaCrm/widgets/daily_calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fhaidaCrm/screens/dummy_chat_screen.dart';
import 'package:fhaidaCrm/screens/dummy_feed.dart';

import 'package:fhaidaCrm/screens/user_details_screen.dart';
import 'package:fhaidaCrm/screens/splash_screen.dart';
import 'package:fhaidaCrm/screens/dashboard_screen.dart';
import 'package:fhaidaCrm/screens/signin_screen(new).dart';
import 'package:fhaidaCrm/screens/signup_screen(new).dart';
import 'package:fhaidaCrm/widgets/bottomNavbar.dart';
import 'package:fhaidaCrm/providers/shared_provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:alarm/alarm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Alarm.init();

  Alarm.ringStream.stream.listen((_) async {
    // Handle the alarm ring event

    Future.delayed(const Duration(milliseconds: 15000), () async {
// Here you can write your code

      await Alarm.stop(_.id);
    });
  });

  LeadFormNotifier().updateAction(LeadAction.purchaseFrom);

  runApp(Phoenix(child: ProviderScope(child: MyApp())));
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
