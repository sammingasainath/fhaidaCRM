import 'package:flutter/material.dart';

class SearchNavbar extends StatelessWidget {
  final Function(String) onSearchChanged;

  SearchNavbar({required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.tealAccent.withOpacity(0.5), blurRadius: 8.0),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: onSearchChanged,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.tealAccent),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
