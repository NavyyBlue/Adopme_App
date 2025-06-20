class CreateAdoptionForm{
  final String name;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String dni;
  final String petId;

  CreateAdoptionForm({
    required this.name,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.dni,
    required this.petId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'dni': dni,
      'petId': petId,
    };
  }

  factory CreateAdoptionForm.fromJson(Map<String, dynamic> json) {
    return CreateAdoptionForm(
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      dni: json['dni'],
      petId: json['petId'],
    );
  }
}