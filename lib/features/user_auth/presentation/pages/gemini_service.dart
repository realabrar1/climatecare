import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey = 'AIzaSyCa6Tn2y2Az1oI9CnqGtS2i5XUbcxOJNLI';
  final String projectNumber = '523705784151';

  Future<List<String>> generateTasks(String category) async {
    final url = 'https://gemini.googleapis.com/v1/generateTasks';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'category': category,
        'project_number': projectNumber,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Extract tasks from response data
      return List<String>.from(data['tasks']);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<String> getTaskExplanation(String task) async {
    final url = 'https://gemini.googleapis.com/v1/taskExplanation';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'task': task,
        'project_number': projectNumber,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Extract explanation from response data
      return data['explanation'];
    } else {
      throw Exception('Failed to load explanation');
    }
  }
}
