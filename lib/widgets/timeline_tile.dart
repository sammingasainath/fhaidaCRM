import 'package:flutter/material.dart';
import '../models/project.dart';

class TimelineTile extends StatelessWidget {
  final Update update;
  final bool isLast;

  const TimelineTile({required this.update, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff7F56D9), Color(0xff592BB5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${update.id}',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60,
                color: Color(0xff7F56D9),
              ),
          ],
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              update.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              update.date,
              style: TextStyle(color: Color.fromARGB(255, 107, 104, 104)),
            ),
          ],
        ),
      ],
    );
  }
}
