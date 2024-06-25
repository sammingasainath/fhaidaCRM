import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:anucivil_client/services/otp_service.dart';
import 'otp_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPhoneScreen extends ConsumerStatefulWidget {
  @override
  _AuthPhoneScreenState createState() => _AuthPhoneScreenState();
}

class _AuthPhoneScreenState extends ConsumerState<AuthPhoneScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  CountryCode _countryCode = CountryCode(
    dialCode: '+91',
  );

  Future<void> _verifyPhoneNumber(BuildContext context) async {
    final String phoneNumber =
        '${_countryCode.dialCode}${_phoneNumberController.text}';
    final authService = ref.read(authServiceProvider);

    await authService.verifyPhoneNumber(
      phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Handle auto sign-in
      },
      verificationFailed: (FirebaseAuthException authException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Verification failed: ${authException.message}')),
        );
      },
      codeSent: (String verId, int? forceResend) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
              phoneNumber: phoneNumber,
              verId: verId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        // Handle auto retrieval timeout
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OTP Authentication',
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
                child: Row(
                  children: <Widget>[
                    CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        setState(() {
                          _countryCode = countryCode;
                        });
                      },
                      initialSelection: _countryCode.dialCode,
                      favorite: ['+1', 'US'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      textStyle: TextStyle(
                        color: Colors.tealAccent,
                        fontFamily: 'Futuristic',
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: TextField(
                        controller: _phoneNumberController,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Futuristic'),
                        decoration: InputDecoration(
                          hintText: '1234567890',
                          hintStyle: TextStyle(color: Colors.tealAccent),
                          labelText: 'Enter your phone number',
                          labelStyle: TextStyle(
                              color: Colors.tealAccent,
                              fontFamily: 'Futuristic'),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.tealAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.tealAccent, width: 2.0),
                          ),
                          filled: true,
                          fillColor: Colors.grey[850],
                        ),
                      ),
                    ),
                  ],
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
                  _verifyPhoneNumber(context);
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
