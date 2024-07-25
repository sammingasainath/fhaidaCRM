import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/project.dart';

class ProjectRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Project>> getProjects() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('projects')
        .where('userID', isEqualTo: _firestore.doc('users/${user.uid}'))
        .snapshots()
        .map((snapshot) {
      
      return snapshot.docs
          .map((doc) =>
              Project.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
          
    });
  }
}
