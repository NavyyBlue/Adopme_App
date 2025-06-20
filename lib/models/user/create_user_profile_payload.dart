class CreateUserProfile {
  String? userId;
  String phoneNumber;

  CreateUserProfile({
    this.userId,
    required this.phoneNumber,
  });

  CreateUserProfile.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        phoneNumber = json['phoneNumber'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['phoneNumber'] = phoneNumber;
    return data;
  }

  bool isEmpty() {
    return userId == null && phoneNumber.isEmpty;
  }
}