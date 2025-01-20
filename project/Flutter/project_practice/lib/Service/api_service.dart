import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/additional_services.dart';
import '../model/rental_types.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api/rentType';

  // Fetch all rental types
  Future<List<RentalTypes>> fetchRentalTypes() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => RentalTypes.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load rental types');
    }
  }

  Future<List<AdditionalServices>> fetchAdditionalServices() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/additionalServices'));

    if (response.statusCode == 200) {
      // If the server returns a successful response, parse the JSON.
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => AdditionalServices.fromJson(item)).toList();
    } else {
      // If the server did not return a 200 response, throw an exception.
      throw Exception('Failed to load additional services');
    }
  }
}
