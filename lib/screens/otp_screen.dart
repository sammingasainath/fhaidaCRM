import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/screens/user_details_screen.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String verId;

  OtpScreen({required this.phoneNumber, required this.verId});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _otpController = TextEditingController();

  void _signInWithPhoneNumber(String smsCode, String verId) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    // Check if user details exist in backend, if not, navigate to details screen
    // Here, you would typically check Firestore or another database for existing user data
    // and navigate accordingly.
    // For simplicity, let's assume direct navigation to the next screen.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => UserDetailsScreen()),
    );
  }

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
                _signInWithPhoneNumber(_otpController.text, widget.verId);
              },
              child: Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
