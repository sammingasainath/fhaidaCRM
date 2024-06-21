// notifiers/user_details_notifier.dart

import 'package:flutter/material.dart';
import 'package:anucivil_client/providers/provider_setup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/services/user_details_service.dart';

final userDetailsNotifierProvider = StateNotifierProvider<UserDetailsNotifier, void>((ref) {
  final userDetailsService = ref.watch(userDetailsServiceProvider);
  return UserDetailsNotifier(userDetailsService);
});

class UserDetailsNotifier extends StateNotifier<void> {
  final UserDetailsService _userDetailsService;

  UserDetailsNotifier(this._userDetailsService) : super(null);

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
    required BuildContext context,
  }) async {
    try {
      await _userDetailsService.saveUserDetails(
        name: name,
        email: email,
        phone: phone,
        street: street,
        town: town,
        district: district,
        state: state,
        pincode: pincode,
        gUrl: gUrl,
        profileImg: profileImg,
      );
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
