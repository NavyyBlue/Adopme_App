class GetFeaturesPetResponse {
  final int status;
  final String species;
  final String breed;
  final int age;
  final int weight;
  final String color;
  final String size;

  GetFeaturesPetResponse({
    required this.status,
    required this.species,
    required this.breed,
    required this.age,
    required this.weight,
    required this.color,
    required this.size,
  });

  factory GetFeaturesPetResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return GetFeaturesPetResponse(
      status: json['status'],
      species: data['species'],
      breed: data['breed'],
      age: data['age'],
      weight: data['weight'],
      color: data['color'],
      size: data['size'],
    );
  }
}