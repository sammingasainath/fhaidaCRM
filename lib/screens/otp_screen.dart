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
      appBar: AppBar(
        title: const Text(
          'OTP Verification',
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
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  style:
                      TextStyle(color: Colors.white, fontFamily: 'Futuristic'),
                  decoration: InputDecoration(
                    hintText: 'Enter OTP',
                    hintStyle: TextStyle(color: Colors.tealAccent),
                    labelText: 'OTP',
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
                  ref.read(authNotifierProvider.notifier).signInWithPhoneNumber(
                      _otpController.text, widget.verId, context);
                },
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
