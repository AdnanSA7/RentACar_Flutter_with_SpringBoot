class CarBookingShow {
  final int id;
  final int carId;
  final String rentalType;
  final String startDate;
  final String? endDate;
  final String pickupLocation;
  final String? dropOffLocation;
  final int? hours; // Nullable for non-hourly rentals
  final double? distance; // Nullable for non-outstation rentals
  final int userId;
  final String userFirstName;
  final String userLastName;
  final int? driverId; // Nullable if no driver is assigned
  final String? driverFirstName; // Nullable if no driver is assigned
  final String? driverLastName; // Nullable if no driver is assigned
  final double cost;
  final String status;
  final List<String> additionalServiceName;
  final bool adminApproval;
  final bool serviceStart;

  CarBookingShow({
    required this.id,
    required this.carId,
    required this.rentalType,
    required this.startDate,
    this.endDate,
    required this.pickupLocation,
    this.dropOffLocation,
    this.hours,
    this.distance,
    required this.userId,
    required this.userFirstName,
    required this.userLastName,
    this.driverId,
    this.driverFirstName,
    this.driverLastName,
    required this.cost,
    required this.status,
    required this.additionalServiceName,
    required this.adminApproval,
    required this.serviceStart,
  });

  factory CarBookingShow.fromJson(Map<String, dynamic> json) {
    return CarBookingShow(
      id: json['id'],
      carId: json['carId'],
      rentalType: json['rentalType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      pickupLocation: json['pickupLocation'],
      dropOffLocation: json['dropOffLocation'],
      hours: json['hours'], // Nullable field
      distance: json['distance'], // Nullable field
      userId: json['userId'],
      userFirstName: json['userFirstName'],
      userLastName: json['userLastName'],
      driverId: json['driverId'], // Nullable field
      driverFirstName: json['driverFirstName'], // Nullable field
      driverLastName: json['driverLastName'], // Nullable field
      cost: json['cost'],
      status: json['status'],
      additionalServiceName: List<String>.from(json['additionalServiceName']),
      adminApproval: json['adminApproval'],
      serviceStart: json['serviceStart'],
    );
  }
}
