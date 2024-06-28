import 'package:flutter/material.dart';
import '../services/pdf_upload.dart';

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
