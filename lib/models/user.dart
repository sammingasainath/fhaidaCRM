// models/user.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String street;
  final String town;
  final String district;
  final String state;
  final String pincode;
  final String gUrl;
  final String profileImg;

  User({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.street,
    required this.town,
    required this.district,
    required this.state,
    required this.pincode,
    required this.gUrl,
    required this.profileImg,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      street: data['address']['street'],
      town: data['address']['town'],
      district: data['address']['district'],
      state: data['address']['state'],
      pincode: data['address']['pincode'],
      gUrl: data['address']['gUrl'],
      profileImg: data['profileImg'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
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
    };
  }
}
