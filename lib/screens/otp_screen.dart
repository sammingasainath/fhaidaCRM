// screens/otp_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anucivil_client/notifiers/otp_notifier.dart';
import 'package:anucivil_client/services/otp_service.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verId;

  OtpScreen({required this.phoneNumber, required this.verId});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OTP Verification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter OTP',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signInWithPhoneNumber(
                    _otpController.text, widget.verId, context);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
