import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/project_provider.dart';
import '../widgets/bottomNavbar.dart';
import '../widgets/searchNavbar.dart';
import '../widgets/project_card.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  return _buildTabContent(selectedTab, ref);
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }

  Widget _buildTabContent(DashboardTab selectedTab, WidgetRef ref) {
    final projectListAsyncValue = ref.watch(filteredProjectListProvider);

    return projectListAsyncValue.when(
      data: (projects) => ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projects[index];
          return ProjectCard(project: project);
        },
      ),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class TabBarWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          isScrollable: true, // Ensure TabBar is scrollable
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
            ref.read(dashboardTabProvider.notifier).state =
                DashboardTab.values[index];
          },
        ),
      ),
    );
  }
}
