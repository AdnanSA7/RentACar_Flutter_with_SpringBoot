class CarBookingShow {
  final int bookingId;
  final String carBrand;
  final String rentalType;
  final DateTime startDate;
  final DateTime endDate;
  final double cost;
  final List<String> additionalServices;

  CarBookingShow({
    required this.bookingId,
    required this.carBrand,
    required this.rentalType,
    required this.startDate,
    required this.endDate,
    required this.cost,
    required this.additionalServices,
  });

  factory CarBookingShow.fromJson(Map<String, dynamic> json) {
    return CarBookingShow(
      bookingId: json['bookingId'],
      carBrand: json['carBrand'],
      rentalType: json['rentalType'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      cost: json['cost'],
      additionalServices: List<String>.from(json['additionalServices']),
    );
  }
}
