import 'dart:io';
import 'package:anucivil_client/providers/custom_boq_provider.dart';
import 'package:anucivil_client/providers/priority_provider.dart';
import 'package:anucivil_client/providers/selected_services_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';
import '../providers/navigation_provider.dart';
import '../screens/project_details_form.dart';

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
      boreHoles: int.parse(boreHolesController.text),
      boreHoleDepth: double.parse(boreHoleDepthController.text),
      selectedServices: ref!.read(selectedServicesProvider),
      area: double.parse(areaController.text),
      remarks: remarksController.text,
      priority:
          ref!.read(priorityProvider) ? ref.read(priorityProvider) : false,
      customBoQ:
          ref!.read(customBoqProvider) ? ref!.read(customBoqProvider) : false,
    );

    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('projects')
        .add(project.toMap());

    String newProjectId = docRef.id;

    // Update the project document with the new ID
    await docRef.update({'id': newProjectId});

    ref.read(selectedIndexProvider1.notifier).state = 0;
  }
}
