class PetResponse {
  final String? name;
  final String? weight;
  final String? size;
  final String? species;
  final String? breed;
  final String? gender;
  final String? age;
  final String? location;
  final String? description;
  final String? color;
  final String? imageUrl;
  final String? petId;
  final String? reportingUserId;

  PetResponse({
    this.name,
    this.weight,
    this.size,
    this.species,
    this.breed,
    this.gender,
    this.age,
    this.location,
    this.description,
    this.color,
    this.imageUrl,
    this.petId,
    this.reportingUserId,
  });

  factory PetResponse.fromJson(Map<String, dynamic> json) {
    return PetResponse(
      name: json['name'],
      weight: json['weight'],
      size: json['size'],
      species: json['species'],
      breed: json['breed'],
      gender: json['gender'],
      age: json['age'],
      location: json['location'],
      description: json['description'],
      color: json['color'],
      imageUrl: json['imageUrl'],
      petId: json['petId'],
      reportingUserId: json['reportingUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'size': size,
      'species': species,
      'breed': breed,
      'gender': gender,
      'age': age,
      'location': location,
      'description': description,
      'color': color,
      'imageUrl': imageUrl,
      'petId': petId,
      'reportingUserId': reportingUserId,
    };
  }
}