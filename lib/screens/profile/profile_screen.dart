import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Text("AB")), // Profile picture
            Text("Student Name"),
            Text("Selected Exam: Exam A"),
            ElevatedButton(
              onPressed: () {
                // Handle logout or update profile
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}
