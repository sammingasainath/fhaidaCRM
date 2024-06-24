import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/project.dart';

class ProjectRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Project>> getProjects() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    QuerySnapshot snapshot = await _firestore
        .collection('projects')
        .where('userID', isEqualTo: _firestore.doc('users/${user.uid}'))
        .get();

    return snapshot.docs
        .map((doc) =>
            Project.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }
}
