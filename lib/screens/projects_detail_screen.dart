import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import '../models/project.dart';
import '../widgets/project_card_comprehensive.dart'; // Ensure this import includes the definition of the Update class

class UpdatesScreen extends StatelessWidget {
  final Project project;

  UpdatesScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Column(
          children: [
            ProjectCardComp(
                project: project), // Add ProjectCard above the TabBar

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

class SummaryTab extends StatelessWidget {
  final Project project;

  SummaryTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 252, 239, 205).withOpacity(0.90),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(0, 2), // Adjust the position of the shadow
                  blurRadius: 2, // Set blur radius to 0 for a sharper shadow
                  spreadRadius: 3, // Adjust the spread radius
                ),
              ],
              borderRadius:
                  BorderRadius.circular(8.0), // Optional: round the corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Please confirm the quotation to start the work. If accepted, you agree to the terms and conditions.',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 255, 136, 0)),
                  ),
                  // Add some spacing between the text and button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 232, 173, 13),
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      // Confirm quotation action
                    },
                    child: Text(
                      'Confirm Quotation',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 13,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: project.updates.length,
              itemBuilder: (context, index) {
                final update = project.updates[index];
                return TimelineTile(
                  update: update,
                  isLast: index == project.updates.length - 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TasksTab extends StatelessWidget {
  final Project project;

  TasksTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Tasks will be displayed here.'),
    );
  }
}

class PaymentsTab extends StatelessWidget {
  final Project project;

  PaymentsTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Agreed Fees: ₹${project.paymentDue}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Payment Received: ₹${project.paymentReceived}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class FilesTab extends StatelessWidget {
  final Project project;

  FilesTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Files will be displayed here.'),
    );
  }
}

class TimelineTile extends StatelessWidget {
  final Update update;
  final bool isLast;

  const TimelineTile({required this.update, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff7F56D9),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${update.id}',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: Color(0xff7F56D9),
              ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              update.date,
              style: TextStyle(color: Color.fromARGB(255, 107, 104, 104)),
            ),
          ],
        ),
      ],
    );
  }
}
