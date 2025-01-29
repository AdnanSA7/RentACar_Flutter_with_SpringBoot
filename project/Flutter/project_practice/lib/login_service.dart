import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String apiUrl = 'http://localhost:8080/api/user/login';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final params =
        '?username=${Uri.encodeComponent(username)}&password=${Uri.encodeComponent(password)}';
    final response = await http.get(Uri.parse('$apiUrl$params'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed: ${response.reasonPhrase}');
    }
  }
}
