import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_fonts/google_fonts.dart';

Future<void> updateProjectStatus(String projectId, String newStatus) async {
  await FirebaseFirestore.instance
      .collection('projects')
      .doc(projectId)
      .update({'status': newStatus});
}

// Ensure you add url_launcher to your pubspec.yaml

void popDialog(BuildContext context, String projectId, String title,
    String subtitle, String statusToChange) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        title: Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        content: Text(
          subtitle,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.redAccent,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Call Now',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.blueAccent,
              ),
            ),
            onPressed: () async {
              // Update the project status in Firebase
              await updateProjectStatus(projectId, statusToChange);
              // Close the dialog and navigate to the home screen
              Navigator.pushReplacementNamed(context, '/');
              // Make the call
              launch('tel:+918331098232');
            },
          ),
        ],
        contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        actionsPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        buttonPadding: EdgeInsets.symmetric(horizontal: 8.0),
      );
    },
  );
}
