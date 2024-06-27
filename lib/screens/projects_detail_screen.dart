import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/project_card_comprehensive.dart';
import '../widgets/summary_tab.dart';
import '../widgets/tasks_tab.dart';
import '../widgets/payments_tab.dart';
import '../widgets/files_tab.dart';

class UpdatesScreen extends StatelessWidget {
  final Project project;

  UpdatesScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(
          children: [
            ProjectCardComp(project: project),
            TabBar(
              indicatorColor: Color(0xff7F56D9),
              tabs: [
                Tab(text: 'Summary'),
                Tab(text: 'Tasks'),
                Tab(text: 'Payments'),
                Tab(text: 'Files'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SummaryTab(project: project),
                  TasksTab(project: project),
                  PaymentsTab(project: project),
                  FilesTab(project: project),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
