import 'dart:convert';

class CarBookingShowFinal {
  final int id;
  final int carId;
  final String brand;
  final String model;
  final String registrationNumber;
  final String rentalType; // "Hourly", "Daily", "Outstation Round Trip"
  final DateTime startDate;
  final DateTime endDate;
  final String pickupLocation;
  final String? dropOffLocation;
  final int? hours; // For Hourly rental
  final int? days;
  final double? distance; // For Outstation Round Trip
  final int driverId;
  final String driverFirstName;
  final String driverLastName;
  final double totalCost;
  final String status;
  final List<String>? additionalServiceName;
  final double initialAmount;
  final String paymentMethod;
  final String transactionId;

  CarBookingShowFinal({
    required this.id,
    required this.carId,
    required this.brand,
    required this.model,
    required this.registrationNumber,
    required this.rentalType,
    required this.startDate,
    required this.endDate,
    required this.pickupLocation,
    this.dropOffLocation,
    this.hours,
    this.days,
    this.distance,
    required this.driverId,
    required this.driverFirstName,
    required this.driverLastName,
    required this.totalCost,
    required this.status,
    this.additionalServiceName,
    required this.initialAmount,
    required this.paymentMethod,
    required this.transactionId,
  });

  // ✅ Convert JSON to Model
  factory CarBookingShowFinal.fromJson(Map<String, dynamic> json) {
    return CarBookingShowFinal(
      id: json['id'],
      carId: json['carId'],
      brand: json['brand'],
      model: json['model'],
      registrationNumber: json['registrationNumber'],
      rentalType: json['rentalType'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      pickupLocation: json['pickupLocation'],
      dropOffLocation: json['dropOffLocation'],
      hours: json['hours'],
      days: json['days'],
      distance: (json['distance'] != null) ? json['distance'].toDouble() : null,
      driverId: json['driverId'],
      driverFirstName: json['driverFirstName'],
      driverLastName: json['driverLastName'],
      totalCost: json['totalCost'].toDouble(),
      status: json['status'],
      additionalServiceName: List<String>.from(json['additionalServiceName'] ?? []),
      initialAmount: json['initialAmount'].toDouble(),
      paymentMethod: json['paymentMethod'],
      transactionId: json['transactionId'],
    );
  }

  // ✅ Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carId': carId,
      'brand': brand,
      'model': model,
      'registrationNumber': registrationNumber,
      'rentalType': rentalType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'pickupLocation': pickupLocation,
      'dropOffLocation': dropOffLocation,
      'hours': hours,
      'days': days,
      'distance': distance,
      'driverId': driverId,
      'driverFirstName': driverFirstName,
      'driverLastName': driverLastName,
      'totalCost': totalCost,
      'status': status,
      'additionalServiceName': additionalServiceName,
      'initialAmount': initialAmount,
      'paymentMethod': paymentMethod,
      'transactionId': transactionId,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
