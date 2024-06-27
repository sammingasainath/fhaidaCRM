import 'package:flutter/material.dart';

class CallToAction {
  final LinearGradient gradient;
  final Color textColor;
  final String message;
  final List<CallToActionButton> buttons;

  CallToAction({
    required this.gradient,
    required this.textColor,
    required this.message,
    required this.buttons,
  });
}

class CallToActionButton {
  final String text;
  final VoidCallback? action;
  final Color color;
  final Color textColor;

  CallToActionButton({
    required this.text,
    required this.action,
    required this.color,
    required this.textColor,
  });
}

CallToAction getCallToAction(String status) {
  switch (status) {
    case 'Action Required':
      return CallToAction(
        gradient:
            LinearGradient(colors: [Colors.red.shade300, Colors.red.shade600]),
        textColor: Colors.white,
        message: 'Upload BOQ to get the quotation',
        buttons: [
          CallToActionButton(
            text: 'Upload',
            action: () {},
            color: Colors.white,
            textColor: Colors.red.shade700,
          ),
        ],
      );
    case 'Quotation Requested':
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.orange.shade300, Colors.orange.shade600]),
        textColor: Colors.white,
        message: 'Quotation has been requested.',
        buttons: [],
      );
    case 'Quotation Sent':
      return CallToAction(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 255, 180, 66),
          Color.fromARGB(255, 255, 171, 103)
        ]),
        textColor: Colors.black,
        message:
            'Please confirm the quotation to start the work. If accepted, you agree to the terms and conditions.',
        buttons: [
          CallToActionButton(
            text: 'Confirm Quotation',
            action: () {},
            color: Color.fromARGB(255, 240, 114, 5),
            textColor: Colors.white,
          ),
          CallToActionButton(
            text: 'View Quotation',
            action: () {},
            color: Colors.grey.shade300,
            textColor: Colors.black,
          ),
        ],
      );
    case 'Quotation Accepted':
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.green.shade300, Colors.green.shade600]),
        textColor: Colors.white,
        message: 'The quotation has been accepted.',
        buttons: [],
      );
    case 'Sampling In Process':
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade600]),
        textColor: Colors.white,
        message: 'Sampling is currently in process.',
        buttons: [],
      );
    case 'Sent To Lab':
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.purple.shade600]),
        textColor: Colors.white,
        message: 'Samples have been sent to the lab.',
        buttons: [],
      );
    case 'reportRecieved':
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.teal.shade600]),
        textColor: Colors.white,
        message: 'The report has been received.',
        buttons: [
          CallToActionButton(
            text: 'View Report',
            action: () {},
            color: Colors.white,
            textColor: Colors.teal.shade700,
          ),
          CallToActionButton(
            text: 'Ship Now',
            action: () {},
            color: Colors.teal.shade700,
            textColor: Colors.white,
          ),
        ],
      );
    case 'reportShipped':
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.brown.shade300, Colors.brown.shade600]),
        textColor: Colors.white,
        message: 'The report has been shipped.',
        buttons: [],
      );
    default:
      return CallToAction(
        gradient: LinearGradient(
            colors: [Colors.grey.shade300, Colors.grey.shade600]),
        textColor: Colors.white,
        message: 'Unknown status.',
        buttons: [],
      );
  }
}
