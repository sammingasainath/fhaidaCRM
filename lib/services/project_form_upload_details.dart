import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';
import '../providers/navigation_provider.dart';

User? user = FirebaseAuth.instance.currentUser;

Future<String?> uploadFileToFirebase(File file) async {
  try {
    final ref =
        FirebaseStorage.instance.ref('boq/${file.path.split('/').last}');
    await ref.putFile(file);
    return await ref.getDownloadURL();
  } catch (e) {
    return null;
  }
}

Future<void> saveProjectDetailsToFirestore(
    {required String name,
    required String location,
    required bool isOwnerDifferent,
    String? ownerName,
    String? ownerPhone,
    required bool customBoQ,
    String? customBoqUrl,
    BuildContext? context,
    WidgetRef? ref}) async {
  if (user != null) {
    String uid = user!.uid;
    DocumentReference userDocRef =
        FirebaseFirestore.instance.collection('users').doc(uid);

    final project = Project(
      id: '',
      location: location,
      name: name,
      paymentDue: 0,
      paymentReceived: 0,
      status: 'Action Required',
      updates: [],
      ownerName: isOwnerDifferent ? ownerName : null,
      ownerPhone: isOwnerDifferent ? ownerPhone : null,
      customBoqUrl: customBoQ ? customBoqUrl : null,
      userID: userDocRef,
    );

    await FirebaseFirestore.instance
        .collection('projects')
        .add(project.toMap());
        
    ref!.read(selectedIndexProvider1.notifier).state = 0;
  }
}
