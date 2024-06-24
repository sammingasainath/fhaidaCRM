import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/screens/dashboard_screen.dart';
import '../providers/navigation_provider.dart';

class BottomNavBar extends ConsumerWidget {
  final List<Widget> screens;

  final List<String> labels = [
    'Projects',
    'Feed',
    '',
    'Alerts',
    'Chat',
  ];

  BottomNavBar({required this.screens});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider1);

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 55, 56, 55).withOpacity(0.5),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < labels.length; i++) _buildNavItem(ref, i),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(WidgetRef ref, int index) {
    final selectedIndex = ref.watch(selectedIndexProvider1);

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          index == 2
              ? SizedBox(
                  height:
                      54.0, // Adjust height to increase size of 'Add' button
                  width: 54.0,
                  child: IconButton(
                    iconSize: 36.0, // Increase size for 'Add' icon
                    icon: Icon(Icons.add_circle),
                    color: Color.fromARGB(
                        255, 158, 15, 235), // Always pink color for 'Add' icon
                    onPressed: () {
                      ref.read(selectedIndexProvider1.notifier).state = index;
                      print('Pressed');
                    },
                  ),
                )
              : IconButton(
                  iconSize: 24.0,
                  icon: Icon(_getIconData(index)),
                  color: index == selectedIndex
                      ? Color.fromARGB(255, 158, 15, 235)
                      : const Color.fromARGB(255, 0, 0, 0),
                  onPressed: () {
                    ref.read(selectedIndexProvider1.notifier).state = index;
                    print('Pressed');
                  },
                ),
          SizedBox(height: 4.0), // Spacer between icon and label
          Text(
            labels[index],
            style: TextStyle(
              fontSize: 12,
              color: index == selectedIndex
                  ? Color.fromARGB(255, 158, 15, 235)
                  : const Color.fromARGB(255, 0, 0, 0),
            ),
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
        return Icons.feed;
      case 2:
        return Icons.add_circle;
      case 3:
        return Icons.crisis_alert_outlined;
      case 4:
        return Icons.chat;
      default:
        return Icons.home;
    }
  }
}
