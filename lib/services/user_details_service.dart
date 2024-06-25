// services/user_details_service.dart

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDetailsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> saveUserDetails({
    required String name,
    required String email,
    required String phone,
    required String street,
    required String town,
    required String district,
    required String state,
    required String pincode,
    required String gUrl,
    required String profileImg,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;

      await _firestore.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'phone': phone,
        'address': {
          'street': street,
          'town': town,
          'district': district,
          'state': state,
          'pincode': pincode,
          'gUrl': gUrl,
        },
        'profileImg': profileImg,
        'UserID': uid
      });
    }
  }
}
