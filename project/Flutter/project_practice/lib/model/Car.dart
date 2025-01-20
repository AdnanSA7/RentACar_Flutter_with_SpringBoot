import 'dart:convert';

class Car {
  int id;
  String brand;
  String model;
  String carImage;
  String categoryName;
  String rentalTypeName;
  double serviceRate;

  Car({
    required this.id,
    required this.brand,
    required this.model,
    required this.carImage,
    required this.categoryName,
    required this.rentalTypeName,
    required this.serviceRate,
  });

  // From JSON
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      model: json['model'],
      carImage: json['carImage'],
      categoryName: json['categoryName'],
      rentalTypeName: json['rentalTypeName'],
      serviceRate: json['serviceRate'].toDouble(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'brand': brand,
      'model': model,
      'carImage': carImage,
      'categoryName': categoryName,
      'rentalTypeName': rentalTypeName,
      'serviceRate': serviceRate,
    };
  }
}

// For example, parsing the JSON string to a List of Car objects
List<Car> parseCars(String jsonString) {
  final List<dynamic> jsonList = json.decode(jsonString);
  return jsonList.map((json) => Car.fromJson(json)).toList();
}
