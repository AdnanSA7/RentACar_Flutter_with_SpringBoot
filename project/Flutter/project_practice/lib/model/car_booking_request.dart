class CarBookingRequest {
  final int carId;
  final int userId;
  final String rentalType;
  final String startDate;
  final String? endDate;
  final String pickupLocation;
  final String? dropOffLocation;
  final int? hours;
  final List<int>? additionalServiceIds;

  CarBookingRequest({
    required this.carId,
    required this.userId,
    required this.rentalType,
    required this.startDate,
    this.endDate,
    required this.pickupLocation,
    this.dropOffLocation,
    this.hours,
    this.additionalServiceIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'userId': userId,
      'rentalType': rentalType,
      'startDate': startDate,
      'endDate': endDate,
      'pickupLocation': pickupLocation,
      'dropOffLocation': dropOffLocation,
      'hours': hours,
      'additionalServiceIds': additionalServiceIds,
    };
  }
}
