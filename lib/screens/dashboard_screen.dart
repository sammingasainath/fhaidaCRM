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
          preferredSize: Size.fromHeight(0),
          child: Container(
            color: Colors.black,
          ), // Empty container to remove the default AppBar
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16.0), // Adjust top padding as needed
                child: Column(
                  children: [
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
        // bottomNavigationBar: BottomNavBar(),
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
    final projectListAsyncValue = ref.watch(projectListProvider);

    return projectListAsyncValue.when(
      data: (projects) {
        int allCount = projects.length;
        int completedCount =
            projects.where((p) => p.status == 'reportRecieved').length;
        int inProgressCount = projects
            .where((p) =>
                p.status == 'Sampling In Process' ||
                p.status == 'Quotation Accepted' ||
                p.status == 'Sent To Lab')
            .length;
        int pendingCount = projects
            .where((p) =>
                p.status == 'Action Required' ||
                p.status == 'Quotation Requested' ||
                p.status == 'Quotation Sent')
            .length;
        int shippedCount =
            projects.where((p) => p.status == 'reportShipped').length;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: TabBar(
              isScrollable: true, // Ensure TabBar is scrollable
              indicatorColor: Color.fromARGB(255, 158, 15, 235),
              indicatorWeight: 4.0,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black.withOpacity(0.6),
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(text: 'All ($allCount)'),
                Tab(text: 'In Progress ($inProgressCount)'),
                Tab(text: 'Completed ($completedCount)'),
                Tab(text: 'Pending ($pendingCount)'),
                Tab(text: 'Shipped ($shippedCount)'),
              ],
              onTap: (index) {
                ref.read(dashboardTabProvider.notifier).state =
                    DashboardTab.values[index];
              },
            ),
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
