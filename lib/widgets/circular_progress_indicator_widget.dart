import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 158, 15, 235)),
      ),
    );
  }
}
