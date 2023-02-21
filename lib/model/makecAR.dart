class makeCar {
  final int id;
  final String name;
  final int isArchive;

  makeCar({required this.id, required this.name, required this.isArchive});

  factory makeCar.fromJson(Map<String, dynamic> json) {
    return makeCar(
      id: json['Id'],
      name: json['Name'],
      isArchive: json['IsArchive'],
    );
  }
}