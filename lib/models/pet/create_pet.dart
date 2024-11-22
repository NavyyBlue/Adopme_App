class CreatePet {
  final String name;
  final String weight;
  final String size;
  final String species;
  final String breed;
  final String age;
  final String gender;
  final String description;
  final String location;
  final String color;
  final String imageUrl;
  final String reportingUserId;

  CreatePet({
    required this.name,
    required this.weight,
    required this.size,
    required this.species,
    required this.breed,
    required this.age,
    required this.gender,
    required this.description,
    required this.location,
    required this.color,
    required this.imageUrl,
    required this.reportingUserId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'size': size,
      'species': species,
      'breed': breed,
      'age': age,
      'gender': gender,
      'description': description,
      'location': location,
      'color': color,
      'imageUrl': imageUrl,
      'reportingUserId': reportingUserId,
    };
  }

  factory CreatePet.fromJson(Map<String, dynamic> json) {
    return CreatePet(
      name: json['name'],
      weight: json['weight'],
      size: json['size'],
      species: json['species'],
      breed: json['breed'],
      age: json['age'],
      gender: json['gender'],
      description: json['description'],
      location: json['location'],
      color: json['color'],
      imageUrl: json['imageUrl'],
      reportingUserId: json['reportingUserId'],
    );
  }
}