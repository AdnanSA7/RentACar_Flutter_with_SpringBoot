import 'dart:convert';
import 'package:http/http.dart' as http;
//
// class LoginService {
//   final String apiUrl = 'http://localhost:8080/api/login';
//
//   Future<Map<String, dynamic>> login(String username, String password) async {
//     final params =
//         '?username=${Uri.encodeComponent(username)}&password=${Uri.encodeComponent(password)}';
//     final response = await http.get(Uri.parse('$apiUrl$params'));
//
//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception('Login failed: ${response.reasonPhrase}');
//     }
//   }
// }

class LoginService {
  final String apiUrl = 'http://localhost:8080/api/login';

  Future<Map<String, dynamic>> login(String username, String password) async {
    final params =
        '?username=${Uri.encodeComponent(username)}&password=${Uri.encodeComponent(password)}';
    final response = await http.get(Uri.parse('$apiUrl$params'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      // Check if the role is "Customer"
      if (data['role'] == 'CUSTOMER') {
        return data; // Return data if the role is valid
      } else {
        throw Exception('Invalid role: Only customers can log in.');
      }
    } else {
      throw Exception('Login failed: ${response.reasonPhrase}');
    }
  }
}
