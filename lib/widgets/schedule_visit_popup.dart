import 'package:flutter/material.dart';

class ScheduleVisitPopup extends StatefulWidget {
  final Function(DateTime) onSchedule;

  ScheduleVisitPopup({required this.onSchedule});

  @override
  _ScheduleVisitPopupState createState() => _ScheduleVisitPopupState();
}

class _ScheduleVisitPopupState extends State<ScheduleVisitPopup> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Schedule Visit'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            child: Text('Select Date'),
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Select Time'),
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: selectedTime,
              );
              if (picked != null && picked != selectedTime) {
                setState(() {
                  selectedTime = picked;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Schedule'),
          onPressed: () {
            final scheduledDateTime = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            widget.onSchedule(scheduledDateTime);
          },
        ),
      ],
    );
  }
}
