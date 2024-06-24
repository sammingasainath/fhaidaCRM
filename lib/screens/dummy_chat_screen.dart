import 'package:flutter/material.dart';

class DummyChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Friends'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Search logic here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(dummyData[index]['profilePic']),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dummyData[index]['name'] ?? '',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(dummyData[index]['message'] ?? ''),
                    ],
                  ),
                  Spacer(),
                  Text(dummyData[index]['time'] ?? ''),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type a message...',
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                // Send message logic here
              },
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, dynamic>> dummyData = [
  {
    'profilePic': 'https://via.placeholder.com/150',
    'name': 'John Doe',
    'essage': 'Hey, what\'s up?',
    'time': '10:05 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/151',
    'name': 'Jane Doe',
    'essage': 'Not much, just chillin\'',
    'time': '10:10 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/152',
    'name': 'Bob Smith',
    'essage': 'Did you see the game last night?',
    'time': '10:15 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/153',
    'name': 'Alice Johnson',
    'essage': 'Yeah, it was crazy!',
    'time': '10:20 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/154',
    'name': 'Mike Brown',
    'essage': 'I know, right?',
    'time': '10:25 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/155',
    'name': 'Emily Davis',
    'essage': 'What\'s up for lunch?',
    'time': '11:00 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/156',
    'name': 'David Lee',
    'essage': 'I was thinking of getting pizza',
    'time': '11:05 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/157',
    'name': 'Sarah Taylor',
    'essage': 'Sounds good to me!',
    'time': '11:10 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/158',
    'name': 'Kevin White',
    'essage': 'I\'ll meet you at 12?',
    'time': '11:15 AM',
  },
  {
    'profilePic': 'https://via.placeholder.com/159',
    'name': 'Lisa Nguyen',
    'essage': 'See you then!',
    'time': '11:20 AM',
  },
];
