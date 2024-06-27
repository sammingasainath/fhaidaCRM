import 'package:flutter/material.dart';
import '../models/project.dart';
import '../services/color_call_to_action_functions.dart';

class CallToActionContainer extends StatelessWidget {
  final Project project;

  CallToActionContainer({required this.project});

  @override
  Widget build(BuildContext context) {
    final callToAction = getCallToAction(project.status);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: callToAction.gradient,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 2),
            blurRadius: 8,
            spreadRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              callToAction.message,
              style: TextStyle(fontSize: 16, color: callToAction.textColor),
            ),
            if (callToAction.buttons.isNotEmpty) ...[
              SizedBox(height: 10),
              Wrap(
                spacing: 8.0, // Horizontal space between buttons
                runSpacing: 8.0, // Vertical space between rows of buttons
                children: callToAction.buttons.map((button) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: button.color,
                      textStyle: TextStyle(
                        color: button.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: button.action,
                    child: Text(
                      button.text,
                      style: TextStyle(color: button.textColor),
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
