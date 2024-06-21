// notifiers/otp_notifier.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anucivil_client/services/otp_service.dart';
import 'package:anucivil_client/screens/otp_screen.dart';
import 'package:anucivil_client/screens/user_details_screen.dart';

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  AuthNotifier(this._authService) : super(false);

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context) async {
    await _authService.verifyPhoneNumber(
      phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        state = true;
        await _authService.signInWithPhoneNumber(
            credential.smsCode!, credential.verificationId!);
        _navigateToUserDetailsScreen(context);
      },
      verificationFailed: (FirebaseAuthException authException) {
        state = false;
        _showErrorDialog(
            context, authException.message ?? "Verification failed");
      },
      codeSent: (String verId, int? forceResend) {
        state = true;
// Navigate to OtpScreen with phone number and verification ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                OtpScreen(phoneNumber: phoneNumber, verId: verId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        state = false;
      },
    );
  }

  Future<void> signInWithPhoneNumber(
      String smsCode, String verId, BuildContext context) async {
    try {
      await _authService.signInWithPhoneNumber(smsCode, verId);
      _navigateToUserDetailsScreen(context);
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _navigateToUserDetailsScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen()),
    );
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

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthNotifier(authService);
});
