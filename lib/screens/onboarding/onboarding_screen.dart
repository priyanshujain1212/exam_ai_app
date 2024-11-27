import 'package:exam_prep_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: use_key_in_widget_constructors
class OnboardingScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController nameController = TextEditingController();
  String selectedOrganization = '';
  String selectedExam = '';
  List<String> organizations = [];
  List<String> exams = [];

  @override
  void initState() {
    super.initState();
    // Fetch the organizations data from the backend when the screen loads
    _fetchOrganizations();
  }

  // Fetch organizations from the backend
  _fetchOrganizations() async {
    try {
      List<String> organizationList = await ApiService.fetchOrganizations();
      setState(() {
        organizations = organizationList;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load organizations");
    }
  }

  // Fetch exams based on selected organization
  _fetchExams(String organization) async {
    try {
      List<String> examList =
          await ApiService.fetchExamsByOrganization(organization);
      setState(() {
        exams = examList;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load exams");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Exam Preparation App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Enter your name"),
            ),
            const SizedBox(height: 20),
            // Organization Dropdown
            organizations.isEmpty
                ? const CircularProgressIndicator() // Show a loading indicator if data is still loading
                : DropdownButton<String>(
                    key: const ValueKey('organizationDropdown'),
                    value: selectedOrganization.isEmpty
                        ? null
                        : selectedOrganization,
                    hint: const Text("Select Organization"),
                    items: organizations
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedOrganization = value!;
                        // Fetch exams when the organization changes
                        _fetchExams(value);
                      });
                    },
                  ),

// Exam Dropdown
            exams.isEmpty
                ? const CircularProgressIndicator() // Show a loading indicator if data is still loading
                : DropdownButton<String>(
                    key: const ValueKey('examDropdown'),
                    value: selectedExam.isEmpty ? null : selectedExam,
                    hint: const Text("Select Exam"),
                    items: exams
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedExam = value!;
                      });
                    },
                  ),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    selectedOrganization.isEmpty ||
                    selectedExam.isEmpty) {
                  Fluttertoast.showToast(msg: "Please fill all fields.");
                  return;
                }

                // Send data to backend
                bool success = await ApiService.saveStudentData(
                    nameController.text, selectedOrganization, selectedExam);

                if (success) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  Fluttertoast.showToast(msg: "Error saving data.");
                }
              },
              child: const Text("Start Preparation"),
            ),
          ],
        ),
      ),
    );
  }
}
