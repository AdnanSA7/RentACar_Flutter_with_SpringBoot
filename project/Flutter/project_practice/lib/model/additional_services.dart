class AdditionalServices {
  final int id;
  final String name;
  final double cost;
  final String description;

  AdditionalServices({
    required this.id,
    required this.name,
    required this.cost,
    required this.description,
  });

  factory AdditionalServices.fromJson(Map<String, dynamic> json) {
    return AdditionalServices(
      id: json['id'],
      name: json['name'],
      cost: json['cost'],
      description: json['description'],
    );
  }
}
