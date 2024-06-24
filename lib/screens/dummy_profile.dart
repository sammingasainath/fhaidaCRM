import 'package:flutter/material.dart';




class DummyAlertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dummy Alerts Screen'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications, color: Colors.red),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Alert ${index + 1}',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text('This is a dummy alert message'),
                          ],
                        ),
                      ),
                      Text('1 hour ago'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red),
                      SizedBox(width: 8),
                      Text('100 likes'),
                      SizedBox(width: 16),
                      Icon(Icons.comment, color: Colors.grey),
                      SizedBox(width: 8),
                      Text('20 comments'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}