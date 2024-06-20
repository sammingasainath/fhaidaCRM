import 'package:anucivil_client/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'otp_screen.dart'; // Assuming this is the correct import path for OtpScreen
import 'user_details_screen.dart'; // Importing UserDetailsScreen

class AuthPhoneScreen extends StatefulWidget {
  @override
  _AuthPhoneScreenState createState() => _AuthPhoneScreenState();
}

class _AuthPhoneScreenState extends State<AuthPhoneScreen> {
  TextEditingController _phoneNumberController = TextEditingController();

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    print('Starting phone number verification...'); // Debug statement

    final PhoneVerificationCompleted verified =
        (PhoneAuthCredential credential) async {
      print(
          'Phone number automatically verified and user signed in: $credential');
      // You can sign in the user automatically if needed:
      // await FirebaseAuth.instance.signInWithCredential(credential);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, int? forceResend) {
      print('SMS code sent to $phoneNumber'); // Debug statement
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              OtpScreen(phoneNumber: phoneNumber, verId: verId),
        ),
      );
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      print('Auto retrieval timeout'); // Debug statement
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verified,
      verificationFailed: verificationFailed,
      codeSent: smsSent,
      codeAutoRetrievalTimeout: autoTimeout,
      timeout: Duration(seconds: 60),
    );

    print('Phone number verification process complete.'); // Debug statement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Phone Authentication',
          style: TextStyle(fontFamily: 'Futuristic', color: Colors.tealAccent),
        ),
        backgroundColor: Colors.black,
        elevation: 10.0,
        shadowColor: Colors.tealAccent,
        centerTitle: true,
        toolbarHeight: 80.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.grey[850]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: _phoneNumberController,
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Futuristic'),
                  decoration: InputDecoration(
                    hintText: '+91 1234567890',
                    hintStyle: TextStyle(color: Colors.tealAccent),
                    labelText: 'Enter your phone number',
                    labelStyle: TextStyle(
                        color: Colors.tealAccent, fontFamily: 'Futuristic'),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.tealAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.tealAccent, width: 2.0),
                    ),
                    filled: true,
                    fillColor: Colors.grey[850],
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent, // Neon color for button
                  foregroundColor: Colors.black, // Button text color
                  textStyle:
                      TextStyle(fontSize: 18.0, fontFamily: 'Futuristic'),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  shadowColor: Colors.tealAccent,
                  elevation: 10.0,
                ),
                onPressed: () {
                  // _verifyPhoneNumber('+91${_phoneNumberController.text}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(),
                    ),
                  );
                },
                child: Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
