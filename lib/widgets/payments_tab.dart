import 'package:flutter/material.dart';
import '../models/project.dart';

class PaymentsTab extends StatelessWidget {
  final Project project;

  PaymentsTab({required this.project});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Agreed Fees: ₹${project.paymentDue}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Payment Received: ₹${project.paymentReceived}',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
