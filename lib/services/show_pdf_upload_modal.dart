//Incomplete


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import '../services/update_project_status_client.dart';

Future<String?> uploadPdf(String projectId) async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

  if (result != null) {
    File file = File(result.files.single.path!);
    String fileName = 'boq_$projectId.pdf';
    try {
      UploadTask uploadTask =
          FirebaseStorage.instance.ref('boq/$fileName').putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('projects')
          .doc(projectId)
          .update({'boqUrl': downloadUrl});

      return downloadUrl;
    } catch (e) {
      print(e);
      return null;
    }
  } else {
    // User canceled the picker
    return null;
  }
}

void showUploadPdfModal(BuildContext context, String projectId) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return UploadPdfModal(projectId: projectId);
    },
  );
}

class UploadPdfModal extends StatelessWidget {
  final String projectId;

  UploadPdfModal({required this.projectId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Upload BOQ PDF',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              String? url = await uploadPdf(projectId);
              if (url != null) {
                updateProjectStatus(projectId, 'Quotation Requested');
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Upload successful!')));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Upload failed!')));
              }
              Navigator.pop(context);
            },
            child: Text('Upload PDF'),
          ),
        ],
      ),
    );
  }
}
