class PetPreferences {
  List<int>? petType;
  List<PetSize>? size;
  List<int>? age;
  List<int>? color;

  PetPreferences({this.petType, this.size, this.age, this.color});

  PetPreferences.fromJson(Map<String, dynamic> json) {
    petType = json['petType'] != null ? List<int>.from(json['petType']) : null;
    size = json['size'] != null
        ? (json['size'] as List)
            .where((i) => i is Map<String, dynamic>)
            .map((i) => PetSize.fromJson(i as Map<String, dynamic>))
            .toList()
        : null;
    age = json['age'] != null ? List<int>.from(json['age']) : null;
    color = json['color'] != null ? List<int>.from(json['color']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['petType'] = this.petType;
    data['size'] =
        this.size != null ? this.size!.map((i) => i.toJson()).toList() : null;
    data['age'] = this.age;
    data['color'] = this.color;
    return data;
  }

  bool isEmpty() {
    return (petType == null || petType!.isEmpty) &&
        (size == null || size!.isEmpty) &&
        (age == null || age!.isEmpty) &&
        (color == null || color!.isEmpty);
  }
}

class PetSize {
  int? min;
  int? max;

  PetSize({this.min, this.max});

  PetSize.fromJson(Map<String, dynamic> json) {
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }

  bool isEmpty() {
    return min == null && max == null;
  }
}
