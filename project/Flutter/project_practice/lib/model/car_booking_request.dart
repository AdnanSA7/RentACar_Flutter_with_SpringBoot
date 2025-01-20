class CarBookingRequest {
  final int carId;
  final int userId;
  final String rentalType;
  final DateTime startDate;
  final DateTime endDate;
  final String pickupLocation;
  final String dropOffLocation;
  final int? hours;
  final double? distance;
  final List<int> additionalServiceIds;

  CarBookingRequest({
    required this.carId,
    required this.userId,
    required this.rentalType,
    required this.startDate,
    required this.endDate,
    required this.pickupLocation,
    required this.dropOffLocation,
    this.hours,
    this.distance,
    required this.additionalServiceIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'userId': userId,
      'rentalType': rentalType,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'pickupLocation': pickupLocation,
      'dropOffLocation': dropOffLocation,
      'hours': hours,
      'distance': distance,
      'additionalServiceIds': additionalServiceIds,
    };
  }
}
