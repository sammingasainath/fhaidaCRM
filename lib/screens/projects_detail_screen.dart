import 'package:anucivil_client/models/lead.dart';
import 'package:flutter/material.dart';
import '../models/project.dart';
import '../widgets/project_card_comprehensive.dart';
import '../widgets/summary_tab.dart';
import '../widgets/tasks_tab.dart';
import '../widgets/edit_tab.dart';
import '../widgets/files_tab.dart';

class DetailsScreen extends StatelessWidget {
  final Lead lead;

  DetailsScreen({required this.lead});

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
            ProjectCardComp(lead: lead),
            TabBar(
              indicatorColor: Color(0xff7F56D9),
              tabs: [
                Tab(text: 'Info'),
                Tab(text: 'Visits'),
                Tab(text: 'Edit'),
                Tab(text: 'Extras'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SummaryTab(
                    lead: lead,
                  ),
                  TasksTab(
                    lead: lead,
                  ),
                  PropertyLeadEditPage(initialData: lead.toMap()),
                  FilesTab(
                    lead: lead,
                  ),
                ],
              ),
            ),
          ],
        ),
        // body: SingleChildScrollView(
        //   child: Text(lead.toMap().toString()),
        // ),
      ),
    );
  }
}
