import 'package:anucivil_client/models/lead.dart';
import 'package:flutter/material.dart';
import '../models/project.dart';

class PaymentsTab extends StatelessWidget {
  final Lead lead;

  PaymentsTab({required this.lead});

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
            'Agreed Fees: ₹}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            'Payment Received: ₹',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
