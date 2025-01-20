import 'dart:convert';

import 'package:http/http.dart' as http;

class UserService {
  final String apiUrl = 'http://localhost:8080/api/user';

  Future<Map<String, dynamic>> findUserById(int id) async {
    final response = await http.get(Uri.parse('$apiUrl/$id'));

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception('Failed to fetch user by ID: ${response.reasonPhrase}');
    }
  }
}