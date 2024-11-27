import 'package:exam_prep_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List mockTests = [];

  @override
  void initState() {
    super.initState();
    // Fetch mock tests from the backend
    _fetchMockTests();
  }

  // Fetch mock tests from the backend based on the selected exam
  _fetchMockTests() async {
    String selectedExam = 'Exam A'; // This should be fetched from backend or state management
    List tests = await ApiService.fetchMockTests(selectedExam);
    setState(() {
      mockTests = tests;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: ListView.builder(
        itemCount: mockTests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(mockTests[index]['title']),
            subtitle: Text(mockTests[index]['description']),
            trailing: ElevatedButton(
              onPressed: () {
                // Start the selected mock test
                Fluttertoast.showToast(msg: "Mock Test started.");
                // Navigate to the mock test screen
                Navigator.pushNamed(context, '/mock_test');
              },
              child: Text("Start"),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Scorecard"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Study Material"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
