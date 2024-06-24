import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildStatusIcon(project.status),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    project.name,
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              '${project.location}, AP',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Agreed Fees: ₹ ${project.paymentDue}',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            Text(
              'Delivery Date: ${project.status == 'reportRecieved' ? '22 June' : 'TBD'}',
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16.0),
            _buildStatusBar(project.status),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    IconData icon;
    Color color;
    switch (status) {
      case 'reportRecieved':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'Sampling In Process':
        icon = Icons.hourglass_empty;
        color = Colors.orange;
        break;
      case 'Action Required':
        icon = Icons.error;
        color = Colors.red;
        break;
      default:
        icon = Icons.info;
        color = Colors.grey;
    }
    return Icon(icon, color: color, size: 24);
  }

  Widget _buildStatusBar(String status) {
    Color color;
    String text;
    IconData icon;
    switch (status) {
      case 'reportRecieved':
        color = Colors.green;
        text = 'Report is being prepared';
        icon = Icons.access_time;
        break;
      case 'Sampling In Process':
        color = Colors.orange;
        text = 'Sampling In Process';
        icon = Icons.hourglass_full;
        break;
      case 'Action Required':
        color = Colors.red;
        text = 'Action Required';
        icon = Icons.warning;
        break;
      default:
        color = Colors.grey;
        text = 'Unknown Status';
        icon = Icons.info;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          SizedBox(width: 4.0),
          Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 14,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
