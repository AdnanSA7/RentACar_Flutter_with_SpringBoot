class RentalTypes {
  int id;
  String rentalTypeName;
  double serviceRate;
  List<String> carCategoryNames;

  RentalTypes({
    required this.id,
    required this.rentalTypeName,
    required this.serviceRate,
    required this.carCategoryNames,
  });

  // From JSON to Dart object
  factory RentalTypes.fromJson(Map<String, dynamic> json) {
    return RentalTypes(
      id: json['id'],
      rentalTypeName: json['rentalType_name'],
      serviceRate: json['serviceRate'].toDouble(),
      carCategoryNames: List<String>.from(json['carCategoryNames']),
    );
  }
}
