import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AssociateCard extends StatelessWidget {
  final String associateName;
  final String associateType;
  final String? associatePhone;

  const AssociateCard({
    Key? key,
    required this.associateName,
    required this.associateType,
    this.associatePhone,
  }) : super(key: key);

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.2),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    associateName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    associateType,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  if (associatePhone != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      associatePhone!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (associatePhone != null)
              IconButton(
                icon: Icon(
                  Icons.call,
                  color: Colors.green,
                ),
                onPressed: () => _makePhoneCall(associatePhone!),
              ),
          ],
        ),
      ),
    );
  }
}
