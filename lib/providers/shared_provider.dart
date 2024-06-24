import 'package:anucivil_client/services/user_details_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// FirebaseAuth instance provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

// Stream of authentication state changes
final authStateChangesProvider = StreamProvider<User?>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return firebaseAuth.authStateChanges();
});

final userDetailsServiceProvider = Provider<UserDetailsService>((ref) {
  return UserDetailsService();
});

// This provider checks if the user's details are complete
final userDetailsCompleteProvider =
    StateNotifierProvider<UserDetailsCompleteNotifier, AsyncValue<bool>>((ref) {
  final userDetailsService = ref.watch(userDetailsServiceProvider);
  return UserDetailsCompleteNotifier(userDetailsService);
});

class UserDetailsCompleteNotifier extends StateNotifier<AsyncValue<bool>> {
  final UserDetailsService _userDetailsService;

  UserDetailsCompleteNotifier(this._userDetailsService)
      : super(AsyncLoading()) {
    checkUserDetails();
  }

  Future<void> checkUserDetails() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          state = AsyncData(true);
        } else {
          state = AsyncData(false);
        }
      } else {
        state = AsyncData(false);
      }
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
