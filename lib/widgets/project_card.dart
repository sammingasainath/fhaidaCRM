import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/project.dart';
import '../services/project_status_service.dart';
import '../widgets/circularProgressIndicator.dart';
import '../screens/projects_detail_screen.dart';

class ProjectCard extends StatelessWidget {
  final Project project;

  ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UpdatesScreen(project: project),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildStatusIcon(project.status),
                        const SizedBox(width: 8.0),
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
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Agreed Fees:',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '₹ ${project.paymentDue}',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color:
                                    ProjectStatusService.getColorBasedOnStatus(
                                        project.status,
                                        isAmount: true),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Date:',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              project.status == 'reportRecieved'
                                  ? '22 June'
                                  : 'TBD',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                color:
                                    ProjectStatusService.getColorBasedOnStatus(
                                        project.status,
                                        isAmount: false),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _buildStatusBar(project.status),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    double progress = ProjectStatusService.getProgress(status);
    Color color = ProjectStatusService.getColor(status);

    return CircularProgressIndicatorWithPercentage(
        progress: progress, color: color);
  }

  Widget _buildStatusBar(String status) {
    Color color = ProjectStatusService.getColor(status);
    String text = ProjectStatusService.getStatusText(status);
    Widget icon =
        ProjectStatusService.getStatusIcon(status); // Change IconData to Widget

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: color.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon, // Use the widget directly
          SizedBox(width: 8.0),
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
