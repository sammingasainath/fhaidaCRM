import 'package:fhaidaCrm/appwrite/services/crud_service.dart';
import 'package:fhaidaCrm/widgets/lead_card.dart';
import 'package:fhaidaCrm/widgets/lead_card_compact.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/lead.dart';
import '../widgets/event_card.dart';
import 'package:url_launcher/url_launcher.dart';

class TasksTab extends StatelessWidget {
  final Lead lead;

  TasksTab({required this.lead});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CallToActionContainer(
          //   lead: lead,
          // ),
          SizedBox(height: 22),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: lead.events!
                    .map((event) => EventCard(event: event))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
