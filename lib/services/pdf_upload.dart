import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

Future<String?> uploadPdf(String projectId) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

  if (result != null) {
    File file = File(result.files.single.path!);
    String fileName = 'boq_$projectId.pdf';
    try {
      UploadTask uploadTask = FirebaseStorage.instance.ref('boq/$fileName').putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('projects').doc(projectId).update({'boqUrl': downloadUrl});

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
