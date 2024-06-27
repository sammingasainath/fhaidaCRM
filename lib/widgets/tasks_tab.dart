import 'package:flutter/material.dart';
import '../models/project.dart';

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
