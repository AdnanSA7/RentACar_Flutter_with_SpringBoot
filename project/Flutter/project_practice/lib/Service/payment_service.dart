import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_practice/model/car_booking_show_final.dart';
import '../model/car_booking_show.dart';

class PaymentService {
  static const String baseUrl = "http://localhost:8080/api/payments";

  Future<CarBookingShowFinal> initiatePayment({
    required int bookingId,
    required String paymentMethod,
    required String transactionId,
    required double initialAmount,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "bookingId": bookingId,
          "paymentMethod": paymentMethod,
          "transactionId": transactionId,
          "initialAmount": initialAmount,
          "amount": amount,
        }),
      );

      if (response.statusCode == 200) {
        return CarBookingShowFinal.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Payment failed: ${response.body}");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
