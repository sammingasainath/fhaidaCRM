import 'package:flutter/material.dart';
import '../models/project.dart';
import 'call_to_action_container.dart';
import 'timeline_tile.dart';

class SummaryTab extends StatelessWidget {
  final Project project;

  SummaryTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CallToActionContainer(project: project),
          SizedBox(height: 22),
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
