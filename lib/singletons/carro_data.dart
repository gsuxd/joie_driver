class CarroData {
  final String brand;
  final String year;
  final String plate;
  final String color;
  final String capacity;
  String picture;

  CarroData(
      {required this.brand,
      required this.year,
      required this.plate,
      required this.color,
      required this.capacity,
      required this.picture});

  factory CarroData.fromJson(Map<String, dynamic> json) {
    return CarroData(
      brand: json['brand'] as String,
      year: json['year'] as String,
      plate: json['plate'] as String,
      color: json['color'] as String,
      capacity: json['capacity'] as String,
      picture: json['picture'] as String,
    );
  }

  toJson() => {
        "brand": brand,
        "year": year,
        "plate": plate,
        "color": color,
        "capacity": capacity,
        "picture": picture
      };
}
