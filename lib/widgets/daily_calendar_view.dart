import 'package:anucivil_client/widgets/event_card.dart';
import 'package:dart_appwrite/dart_appwrite.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:anucivil_client/appwrite/services/crud_service.dart';
import 'package:anucivil_client/models/lead.dart';

class EventCalendarView extends StatefulWidget {
  @override
  _EventCalendarViewState createState() => _EventCalendarViewState();
}

class _EventCalendarViewState extends State<EventCalendarView> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  List<Map<String, dynamic>> _events = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadEvents(_selectedDay!);
  }

  Future<void> _loadEvents(DateTime day) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Query events for the selected day
      final events = await fetchEventsForDate(day);
      setState(() {
        _events = events;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading events: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (
              selectedDay,
              focusedDay,
            ) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                _loadEvents(selectedDay);
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: _events.length,
                    itemBuilder: (context, index) {
                      final event = _events[index];
                      return EventCard(event: event);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// class EventCard extends StatelessWidget {
//   final Map<String, dynamic> event;

//   EventCard({required this.event});

//   @override
//   Widget build(BuildContext context) {
//     DateTime eventDate = DateTime.parse(event['eventDate']);

//     String formatDateTime(DateTime dateTime) {
//       return DateFormat('dd-MM-yyyy – kk:mm').format(dateTime);
//     }

//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Site Visit On ${formatDateTime(eventDate)}',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text('Event ID: ${event['\$id']}'),
//             SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement your logic to view event details or load leads
//               },
//               child: Text('View Details'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Add this function to your crud_service.dart file
Future<List<Map<String, dynamic>>> fetchEventsForDate(DateTime date) async {
  final startOfDay = DateTime(date.year, date.month, date.day);
  final endOfDay =
      startOfDay.add(Duration(days: 1)).subtract(Duration(milliseconds: 1));

  try {
    final result = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: 'events',
      queries: [
        Query.greaterThanEqual('eventDate', startOfDay.toIso8601String()),
        Query.lessThanEqual('eventDate', endOfDay.toIso8601String()),
      ],
    );

    return result.documents.map((doc) => doc.data).toList();
  } catch (e) {
    print('Error fetching events: $e');
    return [];
  }
}
