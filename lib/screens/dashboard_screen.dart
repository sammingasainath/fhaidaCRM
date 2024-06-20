import 'package:anucivil_client/widgets/bottomNavbar.dart';
import 'package:anucivil_client/widgets/searchNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardTab { all, inProgress, completed, pending }

final dashboardTabProvider = StateProvider((ref) => DashboardTab.all);

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: DashboardTab.values.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(3),
          child: Container(
            color: Colors.black,
          ), // Empty container to remove the default AppBar
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.tealAccent.withOpacity(0.5),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0), // Adjust top padding as needed
                child: Column(
                  children: [
                    SearchNavbar(
                      onSearchChanged: (value) {
                        // Handle search functionality
                      },
                    ),
                    SizedBox(height: 8.0), // Adjust as needed
                    TabBarWidget(),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final selectedTab = ref.watch(dashboardTabProvider);
                  return _buildTabContent(selectedTab);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  Widget _buildTabContent(DashboardTab selectedTab) {
    switch (selectedTab) {
      case DashboardTab.all:
        return Center(child: Text('All Tasks'));
      case DashboardTab.inProgress:
        return Center(child: Text('In Progress Tasks'));
      case DashboardTab.completed:
        return Center(child: Text('Completed Tasks'));
      case DashboardTab.pending:
        return Center(child: Text('Pending Tasks'));
      default:
        return Container();
    }
  }
}

class TabBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.tealAccent.withOpacity(0.5),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: TabBar(
          isScrollable: true,
// Ensure TabBar is scrollable
          indicatorColor: Colors.tealAccent,
          labelColor: Colors.tealAccent,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'In Progress'),
            Tab(text: 'Completed'),
            Tab(text: 'Pending'),
          ],
          onTap: (index) {
            // context.read(dashboardTabProvider).state = DashboardTab.values[index];
          },
        ),
      ),
    );
  }
}
