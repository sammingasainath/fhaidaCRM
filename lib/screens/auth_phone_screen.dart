import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:anucivil_client/services/otp_service.dart';
import 'otp_screen.dart';

class AuthPhoneScreen extends StatefulWidget {
  @override
  _AuthPhoneScreenState createState() => _AuthPhoneScreenState();
}

class _AuthPhoneScreenState extends State<AuthPhoneScreen> {
  TextEditingController _phoneNumberController = TextEditingController();
  CountryCode _countryCode = CountryCode(code: '+91', name: 'India');
  final AuthService _authService = AuthService();

  Future<void> _verifyPhoneNumber(String phoneNumber) async {
    print('Starting phone number verification...'); // Debug statement

    _authService.verifyPhoneNumber(
      '${_countryCode.dialCode}${phoneNumber}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print(
            'Phone number automatically verified and user signed in: $credential');
      },
      verificationFailed: (FirebaseAuthException authException) {
        print(
            'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
      },
      codeSent: (String verId, int? forceResend) {
        print(
            'SMS code sent to ${_countryCode.dialCode}$phoneNumber'); // Debug statement
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(
                phoneNumber: '+${_countryCode.dialCode}${phoneNumber}',
                verId: verId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verId) {
        print('Auto retrieval timeout'); // Debug statement
      },
    );

    print('Phone number verification process complete.'); // Debug statement
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
                      favorite: ['+39', 'IN'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
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
                  _verifyPhoneNumber(_phoneNumberController.text);
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
