import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.1.6:8000/api";

  static Future<List<String>> fetchOrganizations() async {
    final response = await http.get(Uri.parse('$baseUrl/organizations'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['organizations'] is List) {
        return (data['organizations'] as List)
            .map((item) => item['name'].toString())
            .toList();
      } else {
        throw Exception('Unexpected data format: organizations not found');
      }
    } else {
      throw Exception('Failed to load organizations');
    }
  }

  // Fetch exams by organization
 static Future<List<String>> fetchExamsByOrganization(String organization) async {
  final response = await http.get(Uri.parse('$baseUrl/exams/$organization'));

  if (response.statusCode == 200) {
    // Decode the response body as a map
    final data = json.decode(response.body);

    // Check if the response contains an 'exams' key, and it's a list
    if (data['exams'] is List) {
      // Map over the list and extract the exam names
      return (data['exams'] as List)
          .map((item) => item['Exam'].toString()) // Adjust the key here based on actual response
          .toList();
    } else {
      throw Exception('Unexpected data format: exams not found');
    }
  } else {
    throw Exception('Failed to load exams');
  }
}


  // Send data to PHP backend
  static Future<bool> saveStudentData(
      String name, String organization, String exam) async {
    final response = await http.post(
      Uri.parse("$baseUrl/student"),
      body: {
        'name': name,
        'organization': organization,
        'exam': exam,
      },
    );
    return response.statusCode == 200;
  }

  // Fetch mock tests from PHP backend
  static Future<List> fetchMockTests(String exam) async {
    final response = await http.get(Uri.parse("$baseUrl/mock-tests/$exam"));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return [];
  }
}
