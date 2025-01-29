import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/car_booking_request.dart';
import '../model/car_booking_show.dart';

class CarBookingService {
  final String apiUrl = 'http://localhost:8080/api/car/available';

  Future<List<dynamic>> fetchAvailableCars(String rentalTypeName, String categoryName, DateTime startDate) async {
    final formattedDate = Uri.encodeComponent(startDate.toIso8601String());
    final params =
        '?rentalTypeName=${Uri.encodeComponent(rentalTypeName)}&categoryName=${Uri.encodeComponent(categoryName)}&startDate=$formattedDate';
    final response = await http.get(Uri.parse('$apiUrl$params'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch available cars: ${response.reasonPhrase}');
    }
  }

  Future<CarBookingShow> createCarBooking(CarBookingRequest bookingRequest) async {
    final url = 'http://localhost:8080/api/bookings'; // Replace with your actual URL

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(bookingRequest.toJson()),
    );

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      return CarBookingShow.fromJson(json.decode(response.body));
    } else {
      // Handle error response
      throw Exception('Failed to create booking');
    }
  }

  Future<List<CarBookingShow>> getBookingsByUserId(int userId) async {
    final url = Uri.parse("http://localhost:8080/api/bookings/user/$userId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => CarBookingShow.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load bookings');
      }
    } catch (e) {
      throw Exception("Error fetching bookings: $e");
    }
  }

}
