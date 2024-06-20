import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/screens/dashboard_screen.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class BottomNavBar extends ConsumerWidget {
  final List<Widget> screens = [
    DashboardScreen(),
    Placeholder(), // Replace with your other screens
    Placeholder(),
    Placeholder(),
  ];

  @override
  Widget build(BuildContext context, ref) {
    final selectedIndex = ref.read(bottomNavIndexProvider).toInt();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.tealAccent.withOpacity(0.5), blurRadius: 8.0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < screens.length; i++)
            IconButton(
              icon: Icon(_getIconData(i)),
              color: i == selectedIndex ? Colors.tealAccent : Colors.white,
              onPressed: () {
                // ref.read(bottomNavIndexProvider) = i;
                print('Pressed');
              },
            ),
        ],
      ),
    );
  }

  IconData _getIconData(int index) {
    switch (index) {
      case 0:
        return Icons.home;
      case 1:
        return Icons.notifications;
      case 2:
        return Icons.person;
      case 3:
        return Icons.settings;
      default:
        return Icons.home;
    }
  }
}
