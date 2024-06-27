import 'package:flutter/material.dart';
import '../models/project.dart';

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
