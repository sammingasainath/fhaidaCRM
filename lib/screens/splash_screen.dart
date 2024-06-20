import 'package:flutter/material.dart';
import '/screens/auth_phone_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.tealAccent, // Neon color for button
              foregroundColor: Colors.black, // Button text color
              textStyle: TextStyle(fontSize: 18.0, fontFamily: 'Futuristic'),
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              shadowColor: Colors.tealAccent,
              elevation: 10.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthPhoneScreen()),
              );
            },
            child: Text('Sign in with Phone Number'),
          ),
        ),
      ),
    );
  }
}
