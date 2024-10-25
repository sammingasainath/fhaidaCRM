import 'package:flutter/material.dart';

class ScheduleVisitPopup extends StatefulWidget {
  final Function(DateTime, Duration) onSchedule;

  ScheduleVisitPopup({required this.onSchedule});

  @override
  _ScheduleVisitPopupState createState() => _ScheduleVisitPopupState();
}

class _ScheduleVisitPopupState extends State<ScheduleVisitPopup> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  int reminderMinutes = 45; // Default reminder time
  bool _isLoading = false; // Add loading flag

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.deepPurple.shade50,
      title: Center(
        child: Text(
          'Schedule Visit',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          _buildDateSelector(),
          SizedBox(height: 16),
          _buildTimeSelector(),
          SizedBox(height: 16),
          Text(
            'Remind Before',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 16),
          _buildReminderDropdown(),
        ],
      ),
      actions: [
        TextButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        _isLoading // Check if loading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Schedule',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // Set loading to true
                  });

                  final scheduledDateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );
                  final reminderDuration = Duration(minutes: reminderMinutes);

                  // Simulate scheduling process
                  await widget.onSchedule(scheduledDateTime, reminderDuration);
                  Navigator.of(context).pop();

                  setState(() {
                    _isLoading = false; // Reset loading after scheduling
                  });

                  Navigator.of(context)
                      .pop(); // Close the popup after scheduling
                },
              ),
      ],
    );
  }

  Widget _buildDateSelector() {
    return GestureDetector(
      onTap: () async {
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.shade200),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Date',
              style: TextStyle(color: Colors.deepPurple),
            ),
            Icon(Icons.calendar_today, color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: () async {
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.deepPurple.shade200),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Select Time',
              style: TextStyle(color: Colors.deepPurple),
            ),
            Icon(Icons.access_time, color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple.shade200),
        color: Colors.white,
      ),
      child: DropdownButton<int>(
        value: reminderMinutes,
        underline: SizedBox(),
        icon: Icon(Icons.notifications, color: Colors.deepPurple),
        dropdownColor: Colors.white,
        isExpanded: true,
        items: [15, 30, 45, 60, 120].map((int value) {
          return DropdownMenuItem(
            value: value,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                ' $value min ',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          );
        }).toList(),
        onChanged: (int? newValue) {
          if (newValue != null) {
            setState(() {
              reminderMinutes = newValue;
            });
          }
        },
      ),
    );
  }
}
