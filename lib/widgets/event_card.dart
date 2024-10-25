import 'package:fhaidaCrm/appwrite/services/crud_service.dart';
import 'package:fhaidaCrm/widgets/lead_card.dart';
import 'package:fhaidaCrm/widgets/lead_card_compact.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/lead.dart';
import 'package:url_launcher/url_launcher.dart';

class EventCard extends StatefulWidget {
  final Map<String, dynamic> event;

  EventCard({required this.event});

  @override
  _EventCardState createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  List<Lead> leads = [];
  bool isLoading = false;
  bool leadsPresent = false;
  var buttonText;

  @override
  Widget build(BuildContext context) {
    DateTime eventDate = DateTime.parse(widget.event['eventDate']);
    DateTime createdAt = DateTime.parse(widget.event['\$createdAt']);
    DateTime updatedAt = DateTime.parse(widget.event['\$updatedAt']);

    String formatDateTime(DateTime dateTime) {
      return DateFormat('dd-MM-yyyy – kk:mm').format(dateTime);
    }

    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Site Visit On ${formatDateTime(eventDate)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text('Event ID: ${widget.event['\$id']}'),
            SizedBox(height: 8),
            if (!leadsPresent)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  leads = await readLeadsWithEvent(widget.event['\$id']);
                  setState(() {
                    isLoading = false;
                    leadsPresent = true;
                  });
                },
                child: Text('Load Leads'),
              ),
            if (leadsPresent)
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  leads = [];
                  setState(() {
                    isLoading = false;
                    leadsPresent = false;
                  });
                },
                child: Text('Hide Leads'),
              ),
            if (isLoading)
              CircularProgressIndicator()
            else if (leads.isNotEmpty)
              Column(
                children: leads
                    .map((lead) => LeadCardComponent(
                          lead: lead,
                          isSelected: false,
                          onTap: () {}, // Implement your onTap logic here
                        ))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
