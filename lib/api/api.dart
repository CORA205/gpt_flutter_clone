import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions";
  final String _apiKey = 'AIzaSyC9SAS7miObxu4ETIDDphrHNWdyg52NVU4';
  final String _model = 'gemini-2.0-flash';

  Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $_apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "model": _model,
        "messages": [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": message},
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Erreur API: ${response.statusCode}');
    }
  }
}
